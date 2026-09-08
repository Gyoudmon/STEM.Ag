#lang typed/racket/base

(provide (all-defined-out))

(require racket/format)
(require plotfun/cartesian)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define make-rough-hookes-law : (-> (Vector Real Real) (Values Real (-> Real Real)))
  (lambda [xy]
    (define k (/ (vector-ref xy 1) (vector-ref xy 0)))

    (values k
            (λ [[x : Real]] : Real
              (* k x)))))

(define hookes-fit/least-square-method : (-> (Listof (Vector Real Real)) (Values Real Real Real Real (-> Real Real)))
  (lambda [data]
    (define N : Real (add1 (length data)))
  
    (define-values (Σx Σy Σxy Σx2 xmax ymax)
      (for/fold ([Σx : Real 0.0]
                 [Σy : Real 0.0]
                 [Σxy : Real 0.0]
                 [Σx2 : Real 0.0]
                 [xmax : Real 0]
                 [ymax : Real 0])
                ([datum (in-list data)])
        (define x : Real (vector-ref datum 0))
        (define y : Real (vector-ref datum 1))
        
        (values (+ Σx x)
                (+ Σy y)
                (+ Σxy (* x y))
                (+ Σx2 (* x x))
                (max x xmax)
                (max y ymax))))
    
    (define xbar : Real (/ Σx N))
    (define ybar : Real (/ Σy N))
    (define k : Real (/ (- Σxy (* N xbar ybar))
                        (- Σx2 (* N xbar xbar))))
    (define b : Real (- ybar (* k xbar)))
    
    (values k b xmax ymax
            (λ [[x : Real]] : Real
              (+ (* k x) b)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define data : (Listof (Vector Real Real))
  (list #(100 8.9)
        #(90 7.5)
        #(80 6.5)
        #(70 5.2)
        #(60 3.9)
        #(50 2.9)
        #(40 1.7)
        #(30 0.6)
        #(20 0.1)))

(define-values (k b xmax ymax fx) (hookes-fit/least-square-method data))
(define x0 (/ (- b) k))

(define hookes-law-plot
  (parameterize ([default-plot-visualizer-label-position 1.0])
    (plot-cartesian #:x-label "m" #:x-desc "砝码质量" #:x-unit-desc "g"
                    #:y-label "ΔL" #:y-desc "长度增量" #:y-unit-desc "cm"
                    #:x-range (cons 0 (max xmax 100)) #:y-range (cons (min b -2.0) (max ymax 10.0))
                    #:mark-style (make-plot-mark-style #:gap-length 4.0 #:pin-angle 0.0 #:gap-angle 0.0)
                    #:width 350 #:height 350
                    
                    (list* (function #:color 'RoyalBlue #:width 2.0
                                     #:label (plot-label #:pin-length (&% 500) #:at 61.8
                                                         #:pin-angle -3pi/4 #:gap-angle -pi/2
                                                         (format "回归直线\n(k = ~a, b = ~a)"
                                                                 (~r k #:precision 4)
                                                                 (~r b #:precision 2)))
                                     fx x0 xmax)
                           
                           (function #:label #false #:color 'RoyalBlue #:dash 'short-dash #:width 2.0
                                     fx 0.0 x0)
                           
                           (points data #:color black)
                           
                           (for/list : (Listof Plot-Visualizer) ([xy (in-list data)]
                                                                 [idx (in-naturals 0)])
                             (define-values (k f) (make-rough-hookes-law xy))
                             (function #:opacity 0.2
                                       #:label (and (zero? (remainder idx 4))
                                                    (format "k = ~a" (~r k #:precision 3)))
                                       f))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module+ main
  (geo-scale hookes-law-plot 1.0))
