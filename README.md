# Decentralized Manufacturing Smart Factory Automation

A comprehensive blockchain-based smart factory automation system built with Clarity smart contracts on the Stacks blockchain. This system provides decentralized management of factory operations, quality control, maintenance coordination, and supply chain integration.

## 🏭 System Overview

The Smart Factory Automation system consists of five core smart contracts that work together to provide a complete manufacturing management solution:

### Core Contracts

1. **Factory Verification Contract** (`factory-verification.clar`)
    - Validates and certifies smart factory automation systems
    - Manages factory registration and verification status
    - Tracks certification levels and compliance

2. **Production Scheduling Contract** (`production-scheduling.clar`)
    - Manages automated production schedules
    - Handles priority-based scheduling
    - Tracks production status and progress

3. **Quality Control Contract** (`quality-control.clar`)
    - Handles automated quality assurance processes
    - Records quality test results and scores
    - Manages pass/fail status determination

4. **Maintenance Coordination Contract** (`maintenance-coordination.clar`)
    - Coordinates predictive maintenance scheduling
    - Manages technician assignments
    - Tracks maintenance costs and completion

5. **Supply Chain Integration Contract** (`supply-chain-integration.clar`)
    - Integrates factory automation with supply chains
    - Manages inventory levels and material consumption
    - Handles supplier orders and delivery tracking

## 🚀 Features

### Factory Management
- **Registration**: Register new factories with location and ownership details
- **Verification**: Verify factory compliance and certification levels
- **Status Tracking**: Monitor factory verification status and dates

### Production Control
- **Scheduling**: Create and manage production schedules with priority levels
- **Status Updates**: Track production progress from scheduled to completed
- **Resource Planning**: Coordinate production with available resources

### Quality Assurance
- **Test Recording**: Record quality control test results with scores
- **Pass/Fail Logic**: Automatic determination based on quality thresholds
- **Batch Tracking**: Monitor quality across product batches

### Maintenance Management
- **Predictive Scheduling**: Schedule maintenance based on equipment needs
- **Technician Assignment**: Assign qualified technicians to maintenance tasks
- **Cost Tracking**: Monitor maintenance costs and completion times

### Supply Chain Integration
- **Order Management**: Create and track supplier orders
- **Inventory Control**: Real-time inventory level monitoring
- **Material Consumption**: Track material usage in production

## 📋 Contract Functions

### Factory Verification
```clarity
;; Register a new factory
(register-factory (name (string-ascii 50)) (location (string-ascii 100)))

;; Verify factory (owner only)
(verify-factory (factory-id uint) (certification-level uint))

;; Get factory details
(get-factory (factory-id uint))
```

### Production Scheduling
```clarity
;; Create production schedule
(create-schedule (factory-id uint) (product-type (string-ascii 50)) 
                (quantity uint) (priority uint) (start-time uint) 
                (estimated-duration uint))

;; Update schedule status
(update-schedule-status (schedule-id uint) (new-status (string-ascii 20)))
```

### Quality Control
```clarity
;; Record quality test
(record-qc-test (factory-id uint) (product-batch (string-ascii 50))
               (test-type (string-ascii 30)) (quality-score uint)
               (notes (string-ascii 200)))

;; Get QC record
(get-qc-record (record-id uint))
```

### Maintenance Coordination
```clarity
;; Schedule maintenance
(schedule-maintenance (factory-id uint) (equipment-id (string-ascii 50))
                     (maintenance-type (string-ascii 30)) (urgency-level uint)
                     (scheduled-date uint) (estimated-cost uint))

;; Assign technician
(assign-technician (maintenance-id uint) (technician principal))
```

### Supply Chain Integration
```clarity
;; Create supply order
(create-supply-order (factory-id uint) (supplier principal)
                    (material-type (string-ascii 50)) (quantity uint)
                    (unit-price uint) (delivery-date uint))

;; Update inventory
(update-inventory (factory-id uint) (material-type (string-ascii 50)) (quantity uint))
```

## 🧪 Testing

The system includes comprehensive test suites using Vitest:

```bash
# Run all tests
npm test

# Run specific contract tests
npm test factory-verification
npm test production-scheduling
npm test quality-control
npm test maintenance-coordination
npm test supply-chain-integration
```

### Test Coverage
- Factory registration and verification
- Production schedule creation and management
- Quality control test recording and validation
- Maintenance scheduling and completion
- Supply chain order and inventory management
- Error handling and edge cases

## 🔧 Installation & Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd smart-factory-automation
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Deploy contracts**
   ```bash
   # Deploy to local testnet
   clarinet deploy --testnet

   # Deploy to mainnet
   clarinet deploy --mainnet
   ```

4. **Run tests**
   ```bash
   npm test
   ```

## 🏗️ Architecture

The system follows a modular architecture where each contract handles a specific aspect of factory operations:

```
┌─────────────────────────────────────────────────────────────┐
│                    Smart Factory System                     │
├─────────────────────────────────────────────────────────────┤
│  Factory Verification  │  Production Scheduling             │
│  - Registration        │  - Schedule Management             │
│  - Certification       │  - Priority Handling               │
│  - Compliance          │  - Status Tracking                 │
├─────────────────────────────────────────────────────────────┤
│  Quality Control       │  Maintenance Coordination          │
│  - Test Recording      │  - Predictive Scheduling           │
│  - Score Validation    │  - Technician Assignment           │
│  - Batch Tracking      │  - Cost Management                 │
├─────────────────────────────────────────────────────────────┤
│              Supply Chain Integration                       │
│              - Order Management                             │
│              - Inventory Control                            │
│              - Material Tracking                            │
└─────────────────────────────────────────────────────────────┘
```

## 🔒 Security Features

- **Access Control**: Role-based permissions for different operations
- **Data Validation**: Input validation and error handling
- **State Management**: Secure state transitions and data integrity
- **Audit Trail**: Complete transaction history and logging

## 📊 Use Cases

1. **Manufacturing Companies**: Automate factory operations and quality control
2. **Supply Chain Managers**: Track materials and coordinate deliveries
3. **Maintenance Teams**: Schedule and manage equipment maintenance
4. **Quality Inspectors**: Record and monitor quality metrics
5. **Factory Operators**: Manage production schedules and resources

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation and examples

---

**Built with ❤️ for the future of decentralized manufacturing**
