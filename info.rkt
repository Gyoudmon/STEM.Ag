#lang info

(define collection "STEM.Ag")
(define pkg-desc "The teaching materials for 碎银几两(五斗米 or Sixpence)")

(define deps '("digimon" "graphics"))
(define build-deps '("digimon" "scribble-lib" "racket-doc"))

(define version "1.0")
(define pkg-authors '("作者: 居老师"))
(define test-omit-paths 'all)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define typesettings
  '(["JMathematicsNotes.scrbl" xelatex]
    ["MathematicsNotes.scrbl" xelatex]
    ["JPhysicsNotes.scrbl" xelatex]
    ["PhysicsNotes.scrbl" xelatex]))
