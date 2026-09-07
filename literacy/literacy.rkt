#lang racket/base

(provide (all-defined-out))
(provide (all-from-out digimon/tamer))
(provide (rename-out [:rdr :desc]))

(require digimon/tamer)
(require digimon/collection)

(require geofun/resize)
(require geofun/digitama/dc/raster)
(require psd/bitmap)

(require scribble/manual)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Just in case for README.md
(enter-digimon-zone!)

(tamer-block-label-separator #false)
(tamer-block-label-tail " ")
(tamer-block-label-style 'bold)

(tamer-default-figure-label "图")
(tamer-default-table-label "表")
(tamer-default-code-label "段")
(tamer-default-algorithm-label "活动")

(tamer-indexed-block-hide-chapter-index #false)

(current-tongue 'zh-Hans)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define /dev/src  (build-path "stone" "src"))

(define stone-image
  (lambda [path #:scale [scale 1.0]]
    (image #:scale (real->double-flonum scale)
           (digimon-path 'stone path))))

(define psd-image
  (lambda [path #:scale [scale 1.0]]
    (define path.psd (digimon-path 'literacy path))

    (elem #:style (make-style #false (list path.psd))
          (geo-scale (geo-bitmap (read-psd-bitmap path.psd)) scale))))

(define geo-vector
  (lambda [g [max-width 380] [max-height 0]]
    (geo-dsfit g max-width max-height)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define idea
  (lambda argv
    (apply racketoutput argv)))

(define focus
  (lambda argv
    (apply racketvalfont argv)))

(define question
  (lambda argv
    (apply racketparenfont argv)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define note-style (make-style "noteStoryTearedPaper" '(multicommand)))
(define note-complain-style (make-style "noteComplain" null))
(define note-bonus-style (make-style "noteBonus" null))
(define note-emph-style (make-style "noteEmph" null))
(define note-question-style (make-style "noteQuestion" null))

(define note-latex-anchor 'exercise)
(define note-index-type 'note:exercise)

(define note-exe
  (lambda [#:tag [maybe-tag #false] . paras]
    (define tag (or maybe-tag (gensym 'exe:)))
    
    (make-tamer-indexed-traverse-block
     #:latex-anchor 'exercise
     (λ [type chapter-index current-index]
       (values tag
               (list (para (format "精选习题 ~a.~a" chapter-index current-index))
                     (decode-compound-paragraph paras))))
     note-index-type
     note-style)))

(define note-complain
  (lambda paras
    (make-nested-flow note-complain-style 
                      (list (apply tamer-indent-paragraphs paras)))))

(define note-bonus
  (lambda paras
    (make-nested-flow note-bonus-style 
                      (list (apply tamer-indent-paragraphs paras)))))

(define note-tag
  (lambda [bcolor fgcolor content]
    (texbook-command "tagBox" #:opt-args (list bcolor) #:args (list fgcolor) content)))

(define note-detailed-tag
  (lambda [bcolor fgcolor title body]
    (texbook-command "tagDetailedBox" #:opt-args (list bcolor) #:args (list fgcolor title) body)))


