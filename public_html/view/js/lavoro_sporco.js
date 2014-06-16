/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * From a previous work of: NG, Yik-wai Jason (Contact & Support: ywng@ust.hk)
 */

var ITWIKI = "https://it.wikipedia.org/wiki/";
var dict = {
    "Aggiungere template": ITWIKI + "Categoria:Aggiungere_template",
    "Aiutare": ITWIKI + "Categoria:Aiutare",
    "Categorizzare": ITWIKI + "Categoria:Categorizzare",
    "Controllare": ITWIKI + "Categoria:Controllare",
    "ControlCopy": ITWIKI + "Categoria:Controllare_copyright",
    "Correggere": ITWIKI + "Categoria:Correggere",
    "Dividere": ITWIKI + "Categoria:Dividere",
    "Enciclopedicita": ITWIKI + "Categoria:Verificare_enciclopedicit%E0",
    "Finzione": ITWIKI + "Categoria:Finzione_non_contestualizzata",
    "Localismo": ITWIKI + "Categoria:Localismo",
    "Organizzare": ITWIKI + "Categoria:Organizzare",
    "Orfane": ITWIKI + "Categoria:Pagine_orfane",
    "Recentismo": ITWIKI + "Categoria:Recentismo",
    "Senza fonti": ITWIKI + "Categoria:Senza_fonti",
    "Chiarire": ITWIKI + "Categoria:Chiarire",
    "Nessuna nota": ITWIKI + "Categoria:Contestualizzare_fonti",
    "Citazione necessaria": ITWIKI + "Categoria:Informazioni_senza_fonte",
    "Stub": ITWIKI + "Categoria:Stub",
    "Stub sezione": ITWIKI + "Categoria:Stub_sezione",
    "Tradurre": ITWIKI + "Categoria:Tradurre",
    "Unire": ITWIKI + "Categoria:Unire",
    "Voci non neutrali": ITWIKI + "Categoria:Voci_non_neutrali",
    "Voci senza uscita": ITWIKI + "Categoria:Voci_senza_uscita",
    "Wikificare": ITWIKI + "Categoria:Wikificare",
};

var mode = [
    "tot",
    "add",
    "rem",
    "diff"
];

var vectorVis = new Array();
var dispatch = d3.dispatch("updateLegend");

_init(1);
_updateDimensions();
_draw(1);

var currentID = 1;

function _draw(id) {
    var idString = mode[id - 1];

    var maxY = findMaxY(idString);
    var minY = findMinY(idString);
    var mousePickerDate;
    var currIndex = data2[0].priceList.length - 1;

    var x = d3.time.scale()
        .range([0, width - 400]),
        x2 = d3.time.scale()
        .range([0, width - 400]);

    var y = d3.scale.linear()
        .range([height, 0]),
        y2 = d3.scale.linear()
        .range([height2, 0]);

    var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");
    xAxis2 = d3.svg.axis()
        .scale(x2).orient("bottom");

    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left")
        .tickFormat(d3.format("d"));

    var line = d3.svg.line()
        .interpolate("linear")
        .x(function (d) {
            return x(d.date);
        })
        .y(function (d) {
            return y(d[idString]);
        });

    var svg = d3.select("#graph").append("svg")
        .attr("width", width - 90 + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom);

    //the main graphic component of the plot
    var focus = svg.append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    //for slider part-----------------------------------------------------------------------------------
    var brush = d3.svg.brush() //for slider bar at the bottom
        .x(x2)
        .on("brush", brushed);

    var context = svg.append("g")
        .attr("transform", "translate(" + margin2.left + "," + margin2.top + ")");

    //append click path for controlling the sliding of curve, clip those part out of bounds
    svg.append("defs").append("clipPath")
        .attr("id", "clip")
        .append("rect")
        .attr("width", width - 400)
        .attr("height", height);

    x.domain([data2[0].priceList[0].date, data2[0].priceList[data2[0].priceList.length - 1].date]);
    y.domain([minY - Math.ceil((maxY - minY) / 7), maxY + Math.ceil((maxY - minY) / 7)]);
    x2.domain(x.domain()); //the domain axis for the bar at the bottom

    context.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height2 + ")")
        .call(xAxis2);

    var contextArea = d3.svg.area()
        .interpolate("monotone")
        .x(function (d) {
            return x2(d.date);
        })
        .y0(height2)
        .y1(0);

    //plot the rect as the bar at the bottom
    context.append("path")
        .attr("class", "area")
        .attr("d", contextArea(data2[0].priceList))
        .attr("fill", "#FFFF8D");


    //append the brush for the selection of subsection  
    context.append("g")
        .attr("class", "x brush")
        .call(brush)
        .selectAll("rect")
        .attr("height", height2)
        .attr("fill", "SkyBlue");
    //end slider part-----------------------------------------------------------------------------------

    //x,y-axis for the plot
    focus.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);

    focus.append("g")
        .attr("class", "y axis")
        .call(yAxis)
        .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Voci");

    //zero line
    if (id == 4) {
        focus.append("svg:line")
            .attr("x1", 0)
            .attr("y1", y(0))
            .attr("x2", width - 400)
            .attr("y2", y(0))
            .style("stroke", "rgb(190,190,190)");
    }

    //curving part of those funds------------------------------------------------------------------------
    var fund = focus.selectAll(".fund")
        .data(data2)
        .enter().append("g")
        .attr("class", "fund");

    fund.append("path")
        .attr("class", "line")
        .attr("clip-path", "url(#clip)") //use clip path to make irrelevant part invisible
        .attr("d", function (d) {
            if (d.vis == "1") {
                return line(d.priceList);
            } else {
                return null;
            }
        })
        .style("stroke", function (d) {
            return colors(d.name);
        });

    //fund name label
    fund.append("text")
        .attr("class", "fundNameLabel")
        .attr("x", function (d, i) {
            if (i < 12) {
                return width - 315;
            } else {
                return width - 160;
            }
        })
        .attr("y", function (d, i) {
            if (i < 12) {
                return i * 45 + 2;
            } else {
                return (i - 12) * 45 + 2;
            }
        })
        .text(function (d) {
            return d.name;
        })
        .style("font-family", "sans-serif")
        .style("font-size", "12px")
        .style("cursor", "pointer")
        .style("font-weight", function (d) {
            if (d.vis == "1") {
                return "bold";
            } else {
                return null;
            }
        })
        .attr("fill", "black")
        .on("click", function (d) {
            window.open(dict[d.name]);
        })
        .on("touchstart", function (d) {
            window.open(dict[d.name]);
        });

    //fund select or dis-select btn
    fund.append("rect")
        .attr("height", 12)
        .attr("width", 25)
        .attr("x", function (d, i) {
            if (i < 12) {
                return width - 345;
            } else {
                return width - 190;
            }
        })
        .attr("y", function (d, i) {
            if (i < 12) {
                return i * 45 - 8;
            } else {
                return (i - 12) * 45 - 8;
            }
        })
        .attr("stroke", function (d) {
            return colors(d.name);
        })
        .attr("fill", function (d) {
            if (d.vis == "1") {
                return colors(d.name);
            } else {
                return "white";
            }
        })
        .on("touchstart", function (d, i) {
            clickVis(d, i);
            updateVis(d, i);
        })
        .on("click", function (d, i) {
            clickVis(d, i)
            updateVis(d, i);
        });

    dispatch.on("updateLegend", function () {
        fund.append("rect").attr("fill", function (d, i) {
            if (vectorVis[i] == 1) {
                d.vis = "1";
            } else {
                d.vis = "0";
            }
            if (i == vectorVis.length - 1) {
                updateVis(d, i)
            }
        });
    });

    //end of curving part of those funds-------------------------------------------------------------	

    //mouse picker related, hover line---------------------------------------------------------------
    var pickerValue = focus.selectAll(".pickerValue") //for displaying fund unit price 
        .data(data2)
        .enter().append("g")
        .attr("class", "pickerValue");

    var valueChange = focus.selectAll(".valueChange") //for displaying unit price percentage change
        .data(data2)
        .enter().append("g")
        .attr("class", "valueChange");

    var hoverLineGroup = focus.append("g") //the vertical line across the plots
        .attr("class", "hover-line");

    var DateLbl = focus.append("g") //the date label at the right upper corner part
        .attr("class", "dateLabel");

    //check the mouse event over the plot area and do the processing 
    container = document.querySelector('#graph');
    $(container).mouseleave(function (event) {
        handleMouseOutGraph(event);
        //console.log("mouse leave");
    })
    $(container).mousemove(function (event) {
        handleMouseOverGraph(event);
        //console.log("mouse move on graph");
    })

    mousePickerDate = getValueForPositionXFromData(width - 400); //initial pick date is the last day of the plot
    //for displaying fund unit price
    pickerValue.append("text")
        .attr("class", "valuesLabel")
        .attr("x", function (d, i) {
            if (i < 12) {
                return width - 345;
            } else {
                return width - 190;
            }
        })
        .attr("y", function (d, i) {
            if (i < 12) {
                return i * 45 + 17;
            } else {
                return (i - 12) * 45 + 17;
            }
        })
        .style("font-weight", function (d) {
            if (d.vis == "1") {
                return "bold";
            } else {
                return null;
            }
        })
        .text(function (d) {
            var dateStr = "";
            //console.log(mousePickerDate);
            dateStr += mousePickerDate.getFullYear();
            if (mousePickerDate.getMonth() + 1 < 10) {
                dateStr += "0" + (mousePickerDate.getMonth() + 1);
            } else {
                dateStr += (mousePickerDate.getMonth() + 1);
            }
            if (mousePickerDate.getDate() < 10) {
                dateStr += "0" + mousePickerDate.getDate();
            } else {
                dateStr += mousePickerDate.getDate();
            }
            //console.log(dateStr);
            currIndex = DateMapIndex.get(dateStr);
            return d.priceList[currIndex][idString];
        })
        .style("font-family", "sans-serif")
        .style("font-size", "12px")
        .attr("fill", function (d) {
            return colors(d.name);
        });

    //for displaying unit price percentage change
    if (id == 1) {
        valueChange.append("text")
            .attr("class", "valuesLabel")
            .attr("x", function (d, i) {
                if (i < 12) {
                    return width - 300;
                } else {
                    return width - 145;
                }
            })
            .attr("y", function (d, i) {
                if (i < 12) {
                    return i * 45 + 15;
                } else {
                    return (i - 12) * 45 + 15;
                }
            })
            .text(function (d) {
                var percentChange;
                if (d.priceList[currIndex] && d.priceList[currIndex - 1])
                    percentChange = (d.priceList[currIndex][idString] - d.priceList[currIndex - 1][idString]) / d.priceList[currIndex - 1][idString] * 100;
                if (percentChange < 0) {
                    return "(" + percentChange.toFixed(2) + "%)"
                } else {
                    return "(+" + percentChange.toFixed(2) + "%)"
                }
            })
            .attr("font-family", "sans-serif")
            .attr("font-size", "15px")
            .attr("fill", function (d) {
                var percentChange;
                if (d.priceList[currIndex] && d.priceList[currIndex - 1])
                    percentChange = (d.priceList[currIndex][idString] - d.priceList[currIndex - 1][idString]) / d.priceList[currIndex - 1][idString] * 100;
                if (percentChange < 0) {
                    return "red"
                } else {
                    return "black"
                }
            });
    }

    function handleMouseOverGraph(event) {
        if ($(window).width() == $(document).width() || $(document).width() - $(window).width() == 1) {
            var mouseX = event.pageX - ($(document).width() - $(".graph").width()) / 2 - 50;
        } else {
            var mouseX = event.pageX - 65;
        }
        var mouseY = event.pageY - 44;

        if (mouseX >= 0 && mouseX <= width - 400 && mouseY >= 80 && mouseY <= height + 70) {
            //show the hover line
            hoverLineGroup.select('line').remove();
            hoverLineGroup.append("line")
                .attr("x1", mouseX).attr("x2", mouseX)
                .attr("y1", 5).attr("y2", height - 5)
                .style("stroke", "DarkViolet")
                .style("stroke-width", 0.3);
            //update date label
            displayDateForPositionX(mouseX);
        } else {
            //out of the bounds that we want
            handleMouseOutGraph(event);
        }
    }

    function handleMouseOutGraph(event) {
        //hide the hover-line
        hoverLineGroup.select('line').remove();

        //Set the value labels to whatever the latest data point is.
        //when the user is not scanning through the graph
        displayDateForPositionX(width - 210);
    }

    //display the data & date values at position X
    function displayDateForPositionX(xPosition) {
        var dateToShow = getValueForPositionXFromData(xPosition);
        mousePickerDate = dateToShow;
        DateLbl.select('text').remove();
        DateLbl.append("text")
            .attr("x", width - 740)
            .attr("y", 0)
            .text(dateToShow)
            .attr("font-family", "sans-serif")
            .attr("font-size", "10px")
            .attr("fill", "Gray");

        //recalculate the current index where the hover lines is on
        var dateStr = "";
        //console.log(mousePickerDate);
        dateStr += mousePickerDate.getFullYear();
        if (mousePickerDate.getMonth() + 1 < 10) {
            dateStr += "0" + (mousePickerDate.getMonth() + 1);
        } else {
            dateStr += (mousePickerDate.getMonth() + 1);
        }
        if (mousePickerDate.getDate() < 10) {
            dateStr += "0" + mousePickerDate.getDate();
        } else {
            dateStr += mousePickerDate.getDate();
        }
        currIndex = DateMapIndex.get(dateStr); //update current index

        //modify the picker display of each funds	
        //do only when we have a defined update of index. For some of the date with no record, the index will be undefined
        if ((currIndex >= 0) && (currIndex < data2[0].priceList.length)) {

            pickerValue.select("text").transition() //update the unit price label 
                .text(function (d) {
                    return d.priceList[currIndex][idString];
                });

            valueChange.select("text").transition() //update % value change label
                .text(function (d) {
                    if (currIndex - 1 < 0)
                        return "";
                    var percentChange = (d.priceList[d.priceList.length - 1][idString] - d.priceList[currIndex - 1][idString]) / d.priceList[currIndex - 1][idString] * 100;
                    if (percentChange < 0) {
                        return "(" + percentChange.toFixed(2) + "%)"
                    } else {
                        return "(+" + percentChange.toFixed(2) + "%)"
                    }
                })
                .attr("fill", function (d) {
                    if (currIndex - 1 < 0)
                        return "black";
                    var percentChange = (d.priceList[d.priceList.length - 1][idString] - d.priceList[currIndex - 1][idString]) / d.priceList[currIndex - 1][idString] * 100;
                    if (percentChange < 0) {
                        return "red"
                    } else {
                        return "black"
                    }
                });
        }

    }

    //for brusher of the slider bar at the bottom
    function brushed() {
        x.domain(brush.empty() ? x2.domain() : brush.extent());
        fund.select("path").transition() //update curve 
            .attr("d", function (d) {
                if (d.vis == "1") {
                    return line(d.priceList);
                } else {
                    return null;
                }
            })
        focus.select(".x.axis").call(xAxis);
    }

    //this function is mainly for accessing the colors
    function getFundID(fundName) {
        for (var i = 0; i < data2.length; i++) {
            if (data2[i].name == fundName)
                return i;
        }
    }

    //get the date on x-axis for the current location
    function getValueForPositionXFromData(xPosition) {
        var xValue = x.invert(xPosition);
        return xValue;
    }

    function clickVis(d, i) {
        if (d.vis == "1") {
            d.vis = "0";
            vectorVis[i] = 0;
        } else {
            d.vis = "1";
            vectorVis[i] = 1;
        }
    }

    //update everything during graph add or rem
    function updateVis(d, i) {
        maxY = findMaxY(idString);
        minY = findMinY(idString);
        if (minY == 9999999) {
            y.domain([0, 0]);
        } else {
            y.domain([minY - Math.ceil((maxY - minY) / 7), maxY + Math.ceil((maxY - minY) / 7)]);
        }
        focus.select(".y.axis").call(yAxis);

        fund.select("path").transition() //update curve 
            .attr("d", function (d) {
                if (d.vis == "1") {
                    return line(d.priceList);
                } else {
                    return null;
                }
            })

        fund.select("rect").transition() //update rect legend 
            .attr("fill", function (d) {
                if (d.vis == "1") {
                    return colors(d.name);
                } else {
                    return "white";
                }
            });

        fund.select("text").transition() //update bold text
            .style("font-weight", function (d) {
                if (d.vis == "1") {
                    return "bold";
                } else {
                    return null;
                }
            })

        pickerValue.select("text").transition() //update bold value
            .style("font-weight", function (d) {
                if (d.vis == "1") {
                    return "bold";
                } else {
                    return null;
                }
            })

        if (id == 4) { //update zero line height
            svg.selectAll("line").remove();
            focus.append("svg:line")
                .attr("x1", 0)
                .attr("y1", y(0))
                .attr("x2", width - 400)
                .attr("y2", y(0))
                .style("stroke", "rgb(190,190,190)");
        }
    }
}

function _updateDimensions() {
    margin = {
        top: 15,
        right: 50,
        bottom: 100,
        left: 50
    };
    width = $(window).width() - margin.left - margin.right;
    if (width < 700) {
        $("#buttonsleg").hide();
    } else {
        $("#buttonsleg").show();
    }
    propHeight = Math.ceil(width / 4 * 3) - 400;
    if (propHeight <= 570)
        propHeight = 570;
    margin2 = {
        top: propHeight - 70,
        right: 50,
        bottom: 50,
        left: 50
    };
    height = propHeight - margin.top - margin.bottom;
    height2 = propHeight - margin2.top - margin2.bottom;
}

//manage window resize event
window.onresize = function () {
    d3.select("svg").remove();
    _updateDimensions();
    _draw(currentID);
}

//fetch new type of data2
function updateData(id) {
    d3.select("svg").remove();
    _draw(id);
    currentID = id;
}

function updateSelectLegend(mode) {
    var i;
    switch (mode) {
    case "all":
        for (i = 0; i < vectorVis.length; i++) {
            vectorVis[i] = 1;
        }
        break;
    case "nothing":
        for (i = 0; i < vectorVis.length; i++) {
            vectorVis[i] = 0;
        }
        break;
    case "toggle":
        for (i = 0; i < vectorVis.length; i++) {
            if (vectorVis[i] == 1) {
                vectorVis[i] = 0;
            } else if (vectorVis[i] == 0) {
                vectorVis[i] = 1;
            }
        }
        break;
    default:
        console.err("updateSelectLegend: received unkwnown mode");
    }
    dispatch.updateLegend();
}