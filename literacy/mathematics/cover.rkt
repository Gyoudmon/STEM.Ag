#lang typed/racket/base

(provide (all-defined-out))

(require geofun/vector)

(require "coordinates/number-axis.rkt")
(require "function.rkt")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define junior-cover-image (geo-vc-append #:gapsize 64.0 integers fractions))
(define senior-cover-image white-cart)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module+ main
  junior-cover-image
  senior-cover-image)
