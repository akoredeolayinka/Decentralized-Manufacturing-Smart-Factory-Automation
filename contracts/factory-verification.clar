;; Factory Verification Contract
;; Validates smart factory automation systems

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_FACTORY_NOT_FOUND (err u101))
(define-constant ERR_ALREADY_VERIFIED (err u102))

;; Factory verification status
(define-map factories
  { factory-id: uint }
  {
    owner: principal,
    name: (string-ascii 50),
    location: (string-ascii 100),
    verified: bool,
    verification-date: uint,
    certification-level: uint
  }
)

(define-data-var factory-counter uint u0)

;; Register a new factory
(define-public (register-factory (name (string-ascii 50)) (location (string-ascii 100)))
  (let ((factory-id (+ (var-get factory-counter) u1)))
    (map-set factories
      { factory-id: factory-id }
      {
        owner: tx-sender,
        name: name,
        location: location,
        verified: false,
        verification-date: u0,
        certification-level: u0
      }
    )
    (var-set factory-counter factory-id)
    (ok factory-id)
  )
)

;; Verify a factory (only contract owner)
(define-public (verify-factory (factory-id uint) (certification-level uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (match (map-get? factories { factory-id: factory-id })
      factory-data
      (begin
        (asserts! (not (get verified factory-data)) ERR_ALREADY_VERIFIED)
        (map-set factories
          { factory-id: factory-id }
          (merge factory-data {
            verified: true,
            verification-date: block-height,
            certification-level: certification-level
          })
        )
        (ok true)
      )
      ERR_FACTORY_NOT_FOUND
    )
  )
)

;; Get factory details
(define-read-only (get-factory (factory-id uint))
  (map-get? factories { factory-id: factory-id })
)

;; Check if factory is verified
(define-read-only (is-factory-verified (factory-id uint))
  (match (map-get? factories { factory-id: factory-id })
    factory-data (ok (get verified factory-data))
    ERR_FACTORY_NOT_FOUND
  )
)
