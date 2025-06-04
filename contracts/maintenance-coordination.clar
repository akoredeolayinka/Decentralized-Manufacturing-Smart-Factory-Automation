;; Maintenance Coordination Contract
;; Coordinates predictive maintenance

(define-constant ERR_UNAUTHORIZED (err u400))
(define-constant ERR_MAINTENANCE_NOT_FOUND (err u401))
(define-constant ERR_INVALID_URGENCY (err u402))

;; Maintenance records
(define-map maintenance-records
  { maintenance-id: uint }
  {
    factory-id: uint,
    equipment-id: (string-ascii 50),
    maintenance-type: (string-ascii 30),
    urgency-level: uint,
    scheduled-date: uint,
    status: (string-ascii 20),
    technician: (optional principal),
    completion-date: (optional uint),
    cost: uint
  }
)

(define-data-var maintenance-counter uint u0)

;; Schedule maintenance
(define-public (schedule-maintenance
  (factory-id uint)
  (equipment-id (string-ascii 50))
  (maintenance-type (string-ascii 30))
  (urgency-level uint)
  (scheduled-date uint)
  (estimated-cost uint)
)
  (begin
    (asserts! (<= urgency-level u5) ERR_INVALID_URGENCY)
    (let ((maintenance-id (+ (var-get maintenance-counter) u1)))
      (map-set maintenance-records
        { maintenance-id: maintenance-id }
        {
          factory-id: factory-id,
          equipment-id: equipment-id,
          maintenance-type: maintenance-type,
          urgency-level: urgency-level,
          scheduled-date: scheduled-date,
          status: "scheduled",
          technician: none,
          completion-date: none,
          cost: estimated-cost
        }
      )
      (var-set maintenance-counter maintenance-id)
      (ok maintenance-id)
    )
  )
)

;; Assign technician
(define-public (assign-technician (maintenance-id uint) (technician principal))
  (match (map-get? maintenance-records { maintenance-id: maintenance-id })
    maintenance-data
    (begin
      (map-set maintenance-records
        { maintenance-id: maintenance-id }
        (merge maintenance-data {
          technician: (some technician),
          status: "assigned"
        })
      )
      (ok true)
    )
    ERR_MAINTENANCE_NOT_FOUND
  )
)

;; Complete maintenance
(define-public (complete-maintenance (maintenance-id uint) (actual-cost uint))
  (match (map-get? maintenance-records { maintenance-id: maintenance-id })
    maintenance-data
    (begin
      (map-set maintenance-records
        { maintenance-id: maintenance-id }
        (merge maintenance-data {
          status: "completed",
          completion-date: (some block-height),
          cost: actual-cost
        })
      )
      (ok true)
    )
    ERR_MAINTENANCE_NOT_FOUND
  )
)

;; Get maintenance record
(define-read-only (get-maintenance-record (maintenance-id uint))
  (map-get? maintenance-records { maintenance-id: maintenance-id })
)
