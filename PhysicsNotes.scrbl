#lang scribble/book

@require{literacy/literacy.rkt}
@require{literacy/physics/cover.rkt}

@(require geofun/vector)

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@handbook-title[
 #:document-options '(openany oneside)
 #:subtitle "架构师的跨学科课堂"
 #:figure @(geo-scale senior-cover-image 0.42)
 #:hide-version? #true
 ]{学神札记·高中物理}

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@texbook-frontmatter[#:docls-book? #true]
@handbook-smart-table[#:phantom? #true]
@texbook-mainmatter[#:docls-book? #true]

@$tex:newcounter[note-latex-anchor]

@texbook-appendix{附录}

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@handbook-bonus-appendix[#:bibliography-section? #false]
