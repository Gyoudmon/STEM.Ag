#lang scribble/report

@require{literacy/literacy.rkt}
@require{literacy/physics/cover.rkt}

@(require geofun/vector)

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@handbook-title[
 #:documentclass 'scrreprt
 #:document-options '((DIV . 12))
 #:subtitle "架构师的跨学科课堂"
 #:figure @(geo-scale @junior-cover-image 0.618)
 #:hide-version? #true
 ]{学神札记·初中物理}

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@texbook-frontmatter[#:docls-book? #false]
@handbook-smart-table[#:phantom? #true]
@texbook-mainmatter[#:docls-book? #false]

@$tex:newcounter[note-latex-anchor]

@texbook-appendix{附录}

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@handbook-bonus-appendix[#:bibliography-section? #false]
