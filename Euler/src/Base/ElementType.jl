"""
 * @ Coding: utf-8
 * @ Author: Yufei.Liu, Calm.Liu@outlook.com | Chenyu.Bao, bcynuaa@163.com
 * @ Date: 2023-09-07 01:37:01
 * @ Copyright: Copyright (c) 2022 - 2023 by SubrosaDG developers. All rights reserved.
 * SubrosaDG is free software and is distributed under the MIT license.
 * @ Description: Here're some brief descriptions about this file.
 * 
 """

abstract type AbstractElementType{NDIMS} end

struct Line <: AbstractElementType{1} end
struct Tri <: AbstractElementType{2} end
struct Quad <: AbstractElementType{2} end

struct Tet <: AbstractElementType{3} end
struct Hex <: AbstractElementType{3} end
struct Pyr <: AbstractElementType{3} end

