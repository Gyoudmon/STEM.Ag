#lang typed/racket

(provide (all-defined-out))

(require geofun/markup)
(require plotfun/cartesian)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (1/x [x : Real]) : (Option Real) (/ 1 x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define vtree : (Listof Plot-Visualizer)
  (parameterize ([default-plot-visualizer-label-placement 'left])
    (list (function #:color 'grey #:dash 'long-dash values #:label #false)
          (function sqrt -3    +4 #:label-position 0.9 #:label-placement 'right)
          (function 1/x  -4    +0 #:fast-range cons #:label "1/x" #:label-position 0.618)
          (function exp  -4    +1.5      #:label (<span> null "e" (<sup> "x")) #:label-position 0.4 #:label-placement 'right)
          (function sqr  -2    +2        #:label (<span> null "x" (<sup> "2")) #:label-position 0.9)
          (function tan  -4    -1.8 #:label-position 0.618 #:label-placement 'right)
          (function log  +1/42 #f))))

(define white-cart
  (plot-cartesian #:x-grid-style #false
                  #:hide-visualizer-label? #false
                  vtree))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module+ main
  white-cart)
