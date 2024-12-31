;; RecogLog: Advanced employee recognition logging system

;; Constants
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_INVALID_INPUT (err u101))
(define-constant ERR_NOT_FOUND (err u102))

;; Data variables
(define-data-var next-id uint u0)

;; Maps
(define-map recognitions
  { id: uint }
  {
    employee: principal,
    text: (string-ascii 280),
    issuer: principal,
    timestamp: uint
  }
)

(define-map employee-recognition-count principal uint)

;; Read-only functions
(define-read-only (get-recognition (id uint))
  (map-get? recognitions { id: id })
)

(define-read-only (get-recognition-count)
  (var-get next-id)
)

(define-read-only (get-employee-recognition-count (employee principal))
  (default-to u0 (map-get? employee-recognition-count employee))
)

;; Public functions
(define-public (log-recognition (employee principal) (text (string-ascii 280)))
  (let
    (
      (id (var-get next-id))
      (issuer tx-sender)
      (timestamp (unwrap-panic (get-block-info? time (- block-height u1))))
    )
    (asserts! (and 
                (> (len text) u0)
                (not (is-eq employee issuer))
               ) ERR_INVALID_INPUT)
    (map-set recognitions
      { id: id }
      {
        employee: employee,
        text: text,
        issuer: issuer,
        timestamp: timestamp
      }
    )
    (map-set employee-recognition-count
      employee
      (+ (get-employee-recognition-count employee) u1)
    )
    (var-set next-id (+ id u1))
    (ok id)
  )
)

(define-public (update-recognition (id uint) (new-text (string-ascii 280)))
  (let ((recognition (unwrap! (get-recognition id) ERR_NOT_FOUND)))
    (asserts! (is-eq (get issuer recognition) tx-sender) ERR_UNAUTHORIZED)
    (asserts! (> (len new-text) u0) ERR_INVALID_INPUT)
    (ok (map-set recognitions
      { id: id }
      (merge recognition { text: new-text })
    ))
  )
)

(define-read-only (get-employee-recognitions (employee principal))
  (filter get-recognition-by-employee (map uint-to-int (iota (get-recognition-count))))
)

(define-private (get-recognition-by-employee (id int))
  (match (map-get? recognitions { id: (to-uint id) })
    recognition (is-eq (get employee recognition) employee)
    false
  )
)