#lang scribble/report

@(require "../../literacy.rkt")

@require{number-axis.rkt}
@require{../../choices.rkt}

@(require geofun/vector)

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@handbook-root-story{数轴}

@tech{数轴}是解析几何的雏形。
它首次用@emph{严谨}的方法帮助孩子建立数字和几何图形的@emph{精确}关系，
为八年级学习坐标系、高中学习解析几何做了铺垫。
在其他理科学习中也有诸多有趣又有用的应用。

@handbook-scenario{数轴}

@handbook-deftech[#:origin "Number Axis"]{数轴}是一条标有@emph{原点}、统一@emph{单位长度}和@emph{正方向}的@emph{直线}。
@tech{数轴}可以朝向任何方向，但通常会@emph{水平}放置，并且规定@emph{右边}为正方向。

@note-problem{
 以下数轴画法正确的是@tamer-choice-blank
 
 @tamer-choices{
  @(para (geo-scale Qnumber-axis.A.nl 0.5))
  @(para (geo-scale Qnumber-axis.B.nl 0.5))
  
  @(para (geo-scale Qnumber-axis.C.nl 0.5))
  @(para (geo-scale Qnumber-axis.D.nl 0.5))}}

@note-solution{
 @bold{答案: B}

 @handbook-itemlist[
 #:style 'compact
 
 @item{@emph{A} 选项错误。@tech{数轴}选定向右为@emph{正方向}，因此右边的数一定大于左边的数。}
 @item{@emph{C} 选项错误。@tech{数轴}的@emph{单位长度}必须统一，-1到0与0到1的差相等，但在此@tech{数轴}上的距离明显不等。}
 @item{@emph{D} 选项很有迷惑性，乍一看没有问题。但它违背了“@tech{数轴}是一条向两端无限延伸的@emph{直线}”，
   该选项中的数轴被画成了射线，因此不对。}
 ]}

@handbook-action{数轴上的点}

所有的有理数都可以精确标定在数轴上。

@handbook-reference[]
