"""
 * @ Coding: utf-8
 * @ Author: Yufei.Liu, Calm.Liu@outlook.com | Chenyu.Bao, bcynuaa@163.com
 * @ Date: 2023-06-01 19:55:39
 * @ Copyright: Copyright (c) 2022 - 2023 by SubrosaDG developers. All rights reserved.
 * SubrosaDG is free software and is distributed under the MIT license.
 * @ Description: Here're some brief descriptions about this file.
 * cal_basisfun_num.jl
 * This file is used to calculate the number of basis functions.
 """

include("elem_type.jl");

"""
# `getBasisFunNum`

## Description

This function is used to calculate the number of basis functions.

## Input

- `elem_info`: the type of the element.
- `poly_order`: the order of the polynomial.

## Output

- `basis_fun_num`: the number of basis functions.

## Example

```julia
basis_fun_num = getBasisFunNum(kLine, 2);
```

output: `3`

## Reference

- [Gmsh manual](https://gmsh.info/doc/texinfo/gmsh.html#MSH-ASCII-file-format)
"""
function getBasisFunNum(elem_info::ElemInfo, poly_order::Int64)::Int64
    if elem_info == kLine
        return poly_order + 1;
    elseif elem_info == kTri
        return (poly_order + 1) * (poly_order + 2) / 2;
    elseif elem_info == kQuad
        return (poly_order + 1) * (poly_order + 1);
    else
        error("The element type is not supported.");
    end
end