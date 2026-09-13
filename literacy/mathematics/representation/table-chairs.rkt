#lang typed/racket/base

(provide (all-defined-out))

(require racket/list)
(require geofun/vector)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define geo-chair : (-> Nonnegative-Real Geo)
  (lambda [r]
    (geo-circle r)))

(define geo-dinning-table : (-> Nonnegative-Real Geo)
  (lambda [r]
    (geo-rectangle (* r 3.2) (* r 8.0))))

(define geo-table+2chairs : (-> Nonnegative-Real Boolean Geo)
  (lambda [r show-hint?]
    (define chair (geo-chair r))
    (define subgroup (geo-vc-append #:gapsize r chair (geo-dinning-table r) chair))

    (cond [(not show-hint?) subgroup]
          [else (geo-frame #:border (desc-stroke #:dash 'long-dash #:color 'FireBrick)
                           #:padding 4.0
                           subgroup)])))

(define geo-table+chairs : (->* () (Positive-Index Boolean) Geo)
  (lambda [[n 1] [show-hint? #false]]
    (define r : Nonnegative-Real 8)
    (define chair (geo-chair r))

    (define vertical-chairs (geo-vc-append #:gapsize (* r 2) chair chair))
    (define table+2chairs (geo-table+2chairs r show-hint?))

    (define extra-chairs
      (cond [(not show-hint?) vertical-chairs]
            [else (geo-frame #:border (desc-stroke #:dash 'long-dash #:color 'RoyalBlue)
                             #:padding 3.0
                             vertical-chairs)]))
    
    (geo-hc-append #:gapsize r
                   extra-chairs
                   (geo-hc-append* #:gapsize 2.0
                                   (make-list n table+2chairs))
                   extra-chairs)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define 1table+chairs : Geo
  (geo-table+chairs))

(define 2tables+chairs : Geo
  (geo-table+chairs 2))

(define 3tables+chairs : Geo
  (geo-table+chairs 3))

(define hi-tables+chairs : Geo
  (geo-table+chairs 4 #true))

(define tables+chairs : Geo
  (geo-hc-append #:gapsize 128.0
                 1table+chairs 2tables+chairs 3tables+chairs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module+ main
  tables+chairs
  hi-tables+chairs

  (define (c [n : Natural]) : Natural
    (+ (* 2 n) 4))

  (map c (list 1 2 3 4 5 6 100)))
