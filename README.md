# RecogLog - Advanced Employee Recognition System

RecogLog is a sophisticated blockchain-based application built using Clarity on the Stacks ecosystem. It enables businesses to log and manage employee recognitions with enhanced features and security.

## Features

- **Log Recognition**: Businesses can add recognitions for employees with automatic ID assignment and timestamp recording.
- **Update Recognition**: Issuers can update the text of existing recognitions.
- **View Recognitions**: Employees can query all recognitions associated with their account.
- **Recognition Counts**: Track the total number of recognitions and per-employee recognition counts.

## Smart Contract Details

### Data Structures

- `recognitions`: Map storing detailed recognition data.
  - Key: `{ id: uint }`
  - Value: `{ employee: principal, text: (string-ascii 280), issuer: principal, timestamp: uint }`
- `employee-recognition-count`: Map tracking the number of recognitions per employee.

### Constants

- `CONTRACT_OWNER`: Set to the contract deployer.
- `ERR_UNAUTHORIZED (err u100)`: Returned for unauthorized actions.
- `ERR_INVALID_INPUT (err u101)`: Returned for invalid input data.
- `ERR_NOT_FOUND (err u102)`: Returned when a requested item is not found.

### Functions

#### Public Functions

1. `log-recognition`
   - Logs a new recognition for an employee.
   - Parameters: `employee (principal)`, `text (string-ascii 280)`
   - Returns: `(ok uint)` with the new recognition ID.

2. `update-recognition`
   - Updates the text of an existing recognition.
   - Parameters: `id (uint)`, `new-text (string-ascii 280)`
   - Returns: `(ok bool)` on success.

#### Read-Only Functions

1. `get-recognition`
   - Retrieves a specific recognition by ID.
   - Parameters: `id (uint)`
   - Returns: Recognition data or `none`.

2. `get-recognition-count`
   - Returns the total number of recognitions.

3. `get-employee-recognition-count`
   - Returns the number of recognitions for a specific employee.
   - Parameters: `employee (principal)`

4. `get-employee-recognitions`
   - Retrieves all recognitions for a specific employee.
   - Parameters: `employee (principal)`
   - Returns: List of recognition IDs.

## How to Use

1. **Deploy the Contract**:
   - Save the code in `contracts/recoglog.clar`.
   - Deploy using Clarinet or the Stacks CLI.

2. **Interact with the Contract**:
   - Use `log-recognition` to add a new recognition.
   - Use `update-recognition` to modify an existing recognition.
   - Use read-only functions to query recognition data.

3. **Testing**:
   - Run `clarinet check` to verify the contract.
   - Use Clarinet's console to interact with the contract and test its functionality.

## Security Considerations

- Only the issuer of a recognition can update it.
- Employees cannot issue recognitions to themselves.
- Input validation is performed to ensure data integrity.

## Future Enhancements

- Implement a role-based access control system.
- Add functionality for bulk recognition issuance.
- Integrate with external systems for automated recognition triggers.