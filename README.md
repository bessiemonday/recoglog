# RecogLog - Employee Recognition Log

RecogLog is a simple blockchain-based application built using Clarity in the Stacks ecosystem. It allows businesses to log employee recognitions, which employees can then view securely and transparently on the blockchain.

## Features
- **Log Recognition**: Businesses can add recognitions for employees with a unique identifier and a short description.
- **View Recognitions**: Employees can query and view all the recognitions associated with their account.

## Smart Contract Details
- **Map Storage**:
  - `recognitions`: Stores employee recognitions.
    - **Key**: `{ employee: principal, recognition-id: uint }`
    - **Value**: `{ recognition-text: (string-ascii 100) }`
- **Error Constants**:
  - `ERR-RECOGNITION-EXISTS (err u100)`: Returned if a recognition with the given ID already exists.
  - `ERR-NOT-AUTHORIZED (err u101)`: Placeholder for future authorization checks (not used in this version).

## Functions
### `log-recognition`
Logs a recognition for an employee.

#### Parameters:
- `employee (principal)`: The employee's blockchain address.
- `recognition-id (uint)`: A unique identifier for the recognition.
- `recognition-text (string-ascii 100)`: A short description of the recognition.

#### Returns:
- `(ok true)` if the recognition is logged successfully.
- `ERR-RECOGNITION-EXISTS` if the recognition ID already exists for the employee.

### `get-recognitions`
Retrieves all recognitions for a specific employee.

#### Parameters:
- `employee (principal)`: The employee's blockchain address.

#### Returns:
- `(ok ...)` containing a list of recognitions for the specified employee.

## How to Use
1. **Deploy the Contract**:
   - Save the code in `contracts/recoglog.clar`.
   - Deploy the contract using Clarinet or the Stacks CLI.

2. **Interact with the Contract**:
   - Use the `log-recognition` function to add a recognition for an employee.
   - Use the `get-recognitions` function to query recognitions for an employee.

3. **Test the Contract**:
   - Run `clarinet check` to ensure the code is error-free.