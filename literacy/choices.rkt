#lang racket/base

(provide (all-defined-out))

(require scribble/base)
(require scribble/core)
(require scribble/decode)

(require digimon/digitama/tamer/block)
(require digimon/digitama/tamer/texbook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define tamer-choice-index-format (make-parameter "~a."))
(define tamer-choice-blank (list ($tex:hfill) "("(hspace 3)")"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define tamer-choices
  (lambda [#:pad:ex [pad:ex '(2.0 2.5)] A B . pre-flows]
    (define choices (decode-flow (list* A B pre-flows)))
    (define block-who (current-block-id))

    (cond [(null? choices) null]
          [(and (null? (cdr choices)) (not (compound-paragraph? (car choices)))) choices]
          [else (tabular-choices choices pad:ex)])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define tabular-choices
  (lambda [src pad]
    (let choice ([choices src]
                 [idx 65]
                 [swor null])
      (if (pair? choices)
          (let-values ([(self rest) (values (car choices) (cdr choices))])
            (cond [(paragraph? self)
                   (let ([cell (choice-single-column self idx)])
                     (choice rest (+ idx 1) (cons cell swor)))]
                  [(compound-paragraph? self)
                   (let-values ([(cell idx++) (choice-columns self idx)])
                     (choice rest idx++ (cons cell swor)))]
                  [else (choice rest idx swor)]))

          (nested #:style heretable-style
                  (tabular #:row-properties '(top)
                           #:pad pad
                           (reverse swor)))))))

(define choice-single-column
  (lambda [self idx]
    (define-values (figure tag) (choice-extract self idx))
    (list ~ (choice-legend tag) figure)))

(define choice-columns
  (lambda [self cpt-idx]
    (let make-choices ([choices (filter paragraph? (compound-paragraph-blocks self))]
                       [idx cpt-idx]
                       [row-choices null])
      (cond [(pair? choices)
             (let*-values ([(self rest) (values (car choices) (cdr choices))]
                           [(figure tag) (choice-extract self idx)])
               (cond [(and figure)
                      (make-choices rest (+ idx 1)
                                    (append row-choices
                                            (list ~ (choice-legend tag) figure)))]
                     [else (make-choices rest idx row-choices)]))]
            [else (values row-choices idx)]))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define choice-extract
  (lambda [p idx]
    (define self (paragraph-content p))

    (if (pair? self)
        (values (list ($tex:vspace 0.0) self)
                (format (tamer-choice-index-format)
                        (string (integer->char idx))))
        (values #false #false))))

(define choice-legend
  (lambda [tag]
    (para tag)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define choiceinside-style (make-style "SubFigureInside" block-style-extras))
