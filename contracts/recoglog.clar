// SPDX-License-Identifier: MIT
// RecogLog - A simple Employee Recognition Log

(define-map recognitions
    { employee: principal, recognition-id: uint }
    { recognition-text: (string-ascii 100) })

(define-constant ERR-RECOGNITION-EXISTS (err u100))   // Recognition already exists
(define-constant ERR-NOT-AUTHORIZED (err u101))       // Caller is not authorized

(define-public (log-recognition (employee principal) (recognition-id uint) (recognition-text (string-ascii 100)))
    (begin
        (if (is-some (map-get recognitions {employee: employee, recognition-id: recognition-id}))
            ERR-RECOGNITION-EXISTS
            (begin
                (map-set recognitions
                    {employee: employee, recognition-id: recognition-id}
                    {recognition-text: recognition-text})
                (ok true)
            )
        )
    )
)

(define-read-only (get-recognitions (employee principal))
    (ok
        (map-filter
            (fn (key value)
                (is-eq (get employee key) employee))
            recognitions)
    )
)
