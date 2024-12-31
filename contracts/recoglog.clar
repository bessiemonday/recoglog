;; RecogLog: Advanced Employee Recognition System

;; Constants
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_RECOGNITION_EXISTS (err u100))
(define-constant ERR_NOT_AUTHORIZED (err u101))
(define-constant ERR_NOT_FOUND (err u102))
(define-constant ERR_INVALID_INPUT (err u103))

;; Data Variables
(define-data-var next-recognition-id uint u0)

;; Maps
(define-map recognitions
  { employee: principal, recognition-id: uint }
  {
    recognition-text: (string-ascii 100),
    issuer: principal,
    timestamp: uint
  }
)

(define-map employee-recognition-count principal uint)

;; Read-only functions
(define-read-only (get-recognition (employee principal) (recognition-id uint))
  (map-get? recognitions { employee: employee, recognition-id: recognition-id })
)

(define-read-only (get-employee-recognition-count (employee principal))
  (default-to u0 (map-get? employee-recognition-count employee))
)

;; Public functions
(define-public (log-recognition (employee principal) (recognition-text (string-ascii 100)))
  (let
    (
      (recognition-id (var-get next-recognition-id))
      (issuer tx-sender)
      (timestamp u0)
    )
    (asserts! (> (len recognition-text) u0) ERR_INVALID_INPUT)
    (asserts! (not (is-eq employee issuer)) ERR_INVALID_INPUT)
    (asserts! (is-none (get-recognition employee recognition-id)) ERR_RECOGNITION_EXISTS)
    (map-set recognitions
      { employee: employee, recognition-id: recognition-id }
      {
        recognition-text: recognition-text,
        issuer: issuer,
        timestamp: timestamp
      }
    )
    (map-set employee-recognition-count
      employee
      (+ (get-employee-recognition-count employee) u1)
    )
    (var-set next-recognition-id (+ recognition-id u1))
    (ok recognition-id)
  )
)

(define-public (update-recognition (employee principal) (recognition-id uint) (new-text (string-ascii 100)))
  (let ((recognition (unwrap! (get-recognition employee recognition-id) ERR_NOT_FOUND)))
    (asserts! (is-eq (get issuer recognition) tx-sender) ERR_NOT_AUTHORIZED)
    (asserts! (> (len new-text) u0) ERR_INVALID_INPUT)
    (ok (map-set recognitions
      { employee: employee, recognition-id: recognition-id }
      (merge recognition { recognition-text: new-text })
    ))
  )
)

(define-read-only (get-employee-recognitions (employee principal))
  (list 
    (get-recognition employee u0)
    (get-recognition employee u1)
    (get-recognition employee u2)
    (get-recognition employee u3)
    (get-recognition employee u4)
    (get-recognition employee u5)
    (get-recognition employee u6)
    (get-recognition employee u7)
    (get-recognition employee u8)
    (get-recognition employee u9)
  )
)