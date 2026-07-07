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
