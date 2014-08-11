/*
 * Copyright (c) 2014
 *     Alessio Melandri <alessio@tools.wmflabs.org> and
 *     Diego Monti <incola@tools.wmflabs.org>.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
 
/*************List of colors for selection*************************/

var colors_map24=["#2F4F4F","#6E5160","#CD853F","#1CAC78","#1CD3A2","#FF0300","#FF6347","#B43800","#FF6700","#FF9A00","#FFCD00","#808000","#B5C200","#BAFF00","#00FF08","#009700","#008B8B","#00BDFF","#0066FF","#2E00FF","#400078","#B000FF","#FF008F","#C20057"];

var colors24 = new Array();
colors24 = d3.scale.ordinal().range(colors_map24);

var colors20 = d3.scale.category20();

var colors10 = d3.scale.category10();