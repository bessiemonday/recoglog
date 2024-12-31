# RecogLog - Advanced Employee Recognition System

RecogLog is a blockchain-based application built using Clarity in the Stacks ecosystem. It enables businesses to log employee recognitions securely and transparently on the blockchain, while employees can view their recognitions. The contract includes functionality for logging, updating, and querying employee recognitions, as well as tracking the number of recognitions per employee.

## Features
- **Log Recognition**: Businesses can add new recognitions for employees, including a unique identifier, recognition text, issuer, and timestamp.
- **Update Recognition**: The original issuer of a recognition can update the recognition text.
- **View Recognitions**: Employees can query their recognitions on the blockchain.
- **Track Recognition Count**: The system tracks how many recognitions each employee has received.
- **Error Handling**: Includes validation checks for recognition uniqueness, valid input, and authorization for updates.

## Smart Contract Details
- **Data Variables**:
  - `next-recognition-id`: Tracks the next unique recognition ID.
- **Maps**:
  - `recognitions`: Stores recognitions with the employee principal, recognition ID, recognition text, issuer, and timestamp.
  - `employee-recognition-count`: Tracks the number of recognitions for each employee.
  
- **Error Constants**:
  - `ERR-RECOGNITION-EXISTS (err u100)`: Returned if a recognition with the given ID already exists.
  - `ERR-NOT-AUTHORIZED (err u101)`: Returned if an unauthorized user attempts to update a recognition.
  - `ERR-NOT-FOUND (err u102)`: Returned if the requested recognition is not found.
  - `ERR-INVALID-INPUT (err u103)`: Returned if the input is invalid (e.g., empty recognition text).

## Functions
### `log-recognition`
Logs a new recognition for an employee.

#### Parameters:
- `employee (principal)`: The employee's blockchain address.
- `recognition-text (string-ascii 100)`: A short description of the recognition.

#### Returns:
- `(ok recognition-id)` if the recognition is logged successfully.
- `ERR-RECOGNITION-EXISTS` if the recognition ID already exists for the employee.

### `update-recognition`
Allows the original issuer to update the recognition text for a specific recognition.

#### Parameters:
- `employee (principal)`: The employee's blockchain address.
- `recognition-id (uint)`: The unique identifier of the recognition.
- `new-text (string-ascii 100)`: The new recognition text.

#### Returns:
- `(ok true)` if the recognition is successfully updated.
- `ERR-NOT-AUTHORIZED` if the sender is not the original issuer.
- `ERR-INVALID-INPUT` if the new recognition text is empty.

### `get-recognition`
Retrieves a specific recognition for an employee.

#### Parameters:
- `employee (principal)`: The employee's blockchain address.
- `recognition-id (uint)`: The unique identifier of the recognition.

#### Returns:
- `(ok recognition-data)` containing the recognition text, issuer, and timestamp.
- `ERR-NOT-FOUND` if the recognition is not found.

### `get-employee-recognition-count`
Retrieves the total number of recognitions received by a specific employee.

#### Parameters:
- `employee (principal)`: The employee's blockchain address.

#### Returns:
- `(ok count)` representing the total number of recognitions for the employee.

### `get-employee-recognitions`
Retrieves all recognitions for a specific employee (limited to 10).

#### Parameters:
- `employee (principal)`: The employee's blockchain address.

#### Returns:
- A list of up to 10 recognitions for the employee.

## How to Use
1. **Deploy the Contract**:
   - Save the contract code in `contracts/recoglog.clar`.
   - Deploy the contract using Clarinet or the Stacks CLI.

2. **Interact with the Contract**:
   - Use the `log-recognition` function to add a recognition for an employee.
   - Use the `update-recognition` function to modify an existing recognition.
   - Use the `get-recognition` function to view a specific recognition.
   - Use the `get-employee-recognition-count` function to check the total number of recognitions for an employee.
   - Use the `get-employee-recognitions` function to view all recognitions for an employee (limited to 10).

3. **Test the Contract**:
   - Run `clarinet check` to ensure the code passes all tests without errors or warnings.

## Future Improvements
- Add dynamic querying for an unlimited number of recognitions per employee.
- Implement actual timestamp functionality based on block height or time.
- Add further authorization checks for logging recognitions, ensuring only authorized users can log recognitions.

