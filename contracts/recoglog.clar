;; RecogLog: A simple employee recognition logging system

;; Error codes
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_INVALID_INPUT (err u101))

;; Data variable for tracking the next recognition ID
(define-data-var next-id uint u0)

;; Principal variable for contract owner
(define-data-var contract-owner principal tx-sender)

;; Map to store recognitions
(define-map recognitions
  { id: uint }
  {
    employee: principal,
    text: (string-ascii 280),
    issuer: principal
  }
)

;; Read-only function to get the contract owner
(define-read-only (get-contract-owner)
  (var-get contract-owner)
)

;; Function to change the contract owner
(define-public (set-contract-owner (new-owner principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) ERR_UNAUTHORIZED)
    (asserts! (not (is-eq new-owner 'SP000000000000000000002Q6VF78)) ERR_INVALID_INPUT)
    (ok (var-set contract-owner new-owner))
  )
)

;; Function to log a new recognition
(define-public (log-recognition (employee principal) (text (string-ascii 280)))
  (let
    (
      (id (var-get next-id))
    )
    (asserts! (and 
                (> (len text) u0)
                (not (is-eq employee 'SP000000000000000000002Q6VF78))
               ) ERR_INVALID_INPUT)
    (map-set recognitions
      { id: id }
      {
        employee: employee,
        text: text,
        issuer: tx-sender
      }
    )
    (ok (var-set next-id (+ id u1)))
  )
)

;; Read-only function to get a specific recognition
(define-read-only (get-recognition (id uint))
  (map-get? recognitions { id: id })
)

;; Read-only function to get the total number of recognitions
(define-read-only (get-recognition-count)
  (var-get next-id)
)

