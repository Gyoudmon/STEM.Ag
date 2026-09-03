#lang typed/racket/base

(provide (all-defined-out))

(require geofun/vector)
(require plotfun/line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define no-tick-style (make-plot-axis-style #:tip plot-strict-tip #:tick-length 0.0))
(define strict-style (make-plot-axis-style #:tip plot-strict-tip))
(define no-pin-style (plot-template 0.0 -pi/2 #:pin? #false))
(define gapped-no-pin-style (plot-template (&% 61.8) -pi/2 #:pin? #false))

(define interval-pen (desc-stroke #:dash 'long-dash))
(define number-axis-length 300.0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define nl-interval-sticker : (-> Real Nonnegative-Real Font Geo-Sticker)
  (lambda [unit scale font]
    (make-sticker (geo-path #:stroke interval-pen
                            #:labels (make-geo-path-label scale #:font font)
                            #:scale (* unit scale)
                            (list (list 0.0 0.5-0.5i 1.0)))
                  'lb)))

(define interval-desc : Plot-Mark->Description
  (lambda [pt datum font color transform]
    (define unit (real-part (- (transform 1.0+0.0i) (transform 0.0+0.0i))))
    (define n (real-part pt))

    (cond [(= n 0) (nl-interval-sticker unit 2 font)]
          [(= n 2) (nl-interval-sticker unit 1 font)])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define rational-desc : Plot-Mark->Description
  (lambda [pt datum font color transform]
    (define unit (real-part (- (transform 1.0+0.0i) (transform 0.0+0.0i))))
    (define offset (* unit 0.1-0.01i))
    (define n (real-part pt))

    (if (>= n 0)
        (when (< n 4)
          (make-sticker (geo-path #:stroke 'ForestGreen #:target-tip default-arrow-tip
                                  #:labels (make-geo-path-label "+1" #:font font #:color 'ForestGreen)
                                  #:scale unit
                                  (list (list 0.1 0.5-0.16i 0.9)))
                        'lb offset))

        (make-sticker (geo-path #:stroke 'Crimson #:target-tip default-arrow-tip
                                #:labels (make-geo-path-label "-1" #:font font #:color 'Crimson)
                                #:scale (* unit -1.0+1.0i)
                                (list (list 0.1 0.5-0.16i 0.9)))
                      'lb offset))))

(define frational-desc : (-> Positive-Byte Plot-Mark->Description)
  (lambda [d]
    (λ [pt datum font color transform]
      (define unit (real-part (- (transform 1.0+0.0i) (transform 0.0+0.0i))))
      
      (when (and (real? pt) (exact? pt))
        (define scale (/ unit (exact->inexact d)))
        
        (for/list : (Listof Geo-Sticker) ([idx (in-range 0 d)])
                (if (> idx 0)
                    (make-sticker (geo-path #:stroke 'RoyalBlue #:target-tip default-arrow-tip
                                            #:labels (make-geo-path-label #:font font #:color 'RoyalBlue #:rotate? #false
                                                                          (format "×~a" (add1 idx)) 0.618)
                                            #:scale (* scale idx)
                                            (list (list 0.0 0.16-0.4i 0.975)))
                                  'lb)
                    (make-sticker (geo-path #:stroke 'Crimson #:target-tip default-arrow-tip
                                            #:labels (make-geo-path-label #:font font #:color 'Crimson #:rotate? #false
                                                                          "×0" 0.618)
                                            #:scale (* scale (- idx 1) 1.0-1.0i)
                                            (list (list 0.0 0.16-0.4i 0.95)))
                                  'rb)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define Qnumber-axis.A.nl : Geo
  (plot-line #:ticks (plot-fixed-ticks '(-2 -1 0 1 2) '("-1" "-2"))
             #:length number-axis-length #:range (cons -2.5 2.5)
             #:style strict-style
             null))

(define Qnumber-axis.B.nl : Geo
  (plot-line #:ticks (plot-fixed-ticks '(-2 -1 0 1 2))
             #:length number-axis-length #:range (cons -2.5 2.5)
             #:style strict-style
             null))

(define Qnumber-axis.C.nl : Geo
  (plot-line #:ticks (plot-fixed-ticks '(-2 -1 2) '("-1" "0" "1"))
             #:length number-axis-length #:range (cons -2.5 2.5)
             #:style strict-style
             null))

(define Qnumber-axis.D.nl : Geo
  (plot-line #:ticks (plot-fixed-ticks '(0 1 2 3 4))
             #:length number-axis-length #:range (cons 0 5)
             null))

(define Qrelative-position.nl : Geo
  (plot-line #:mark-template (remake-plot:mark no-pin-style #:desc interval-desc)
             #:ticks (plot-fixed-ticks '(0 2 3) '("A" "B" "C"))
             #:length number-axis-length #:range (cons -0.5 4.0)
             #:style no-tick-style
             (list 0 2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define integers : Geo
  (plot-line #:label "Z"
             #:origin 0.5
             #:ticks (plot-real-ticks* #:minor-count 0)
             #:style strict-style
             #:range (cons -4 4)
             #:mark-template (remake-plot:mark gapped-no-pin-style #:desc rational-desc)
             (list -4 -3 -2 -1 0 1 2 3 4)))

(define fractions : Geo
  (let ([d 5])
    (plot-line #:label "Q"
               #:ticks (plot-fixed-ticks (append (list 0) (build-list (sub1 d) (λ [[i : Index]] (/ (+ i 1) d))) (list 1)))
               #:style strict-style
               #:range (cons 0 1)
               #:mark-template (remake-plot:mark gapped-no-pin-style #:desc (frational-desc d))
               (list (/ 1 d)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module+ main
  Qnumber-axis.A.nl
  Qnumber-axis.B.nl
  Qnumber-axis.C.nl
  Qnumber-axis.D.nl
  Qrelative-position.nl
  
  integers
  fractions)
