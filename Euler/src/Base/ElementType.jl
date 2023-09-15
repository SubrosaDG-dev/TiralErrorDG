"""
 * @ Coding: utf-8
 * @ Author: Yufei.Liu, Calm.Liu@outlook.com | Chenyu.Bao, bcynuaa@163.com
 * @ Date: 2023-09-07 01:37:01
 * @ Copyright: Copyright (c) 2022 - 2023 by SubrosaDG developers. All rights reserved.
 * SubrosaDG is free software and is distributed under the MIT license.
 * @ Description: Here're some brief descriptions about this file.
 * 
 """

abstract type AbstractElementType end

abstract type AdjacencyElement <: AbstractElementType end
abstract type IntegralElement <: AbstractElementType end

struct Line2D <: AdjacencyElement end

struct Tri2D <: IntegralElement end
struct Quad2D <: IntegralElement end

const kLine2D::Line2D = Line2D()
const kTri2D::Tri2D = Tri2D()
const kQuad2D::Quad2D = Quad2D()