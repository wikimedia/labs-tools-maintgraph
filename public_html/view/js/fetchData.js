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

//The main data array of the graph
//format:
//dataSet (List of fundObj)
//   fundObj (Name, priceList)
//      Name
//      priceList (List of priceItem)
//         priceItem (date, price)
var dataSet;

var parseDate = d3.time.format("%Y%m%d").parse;
var fundName=new Array();
var DateMapIndex=d3.map();

var start = 1;

function _init(dataID){
    // fetch data from database
    //should have some sort of API for getting the data
    $.ajax({
        url: dataSetUrl,
        context: document.body,
        dataType: "json",
        headers : {Accept : "application/json","Access-Control-Allow-Origin" : "*"},
        type: 'GET',
        async: false,
        success: function(data, textStatus, jqXHR){
            dataSet=new Array();
            for(var i=0; i < data.length; i++) {
                var fund=new Object();
                fund.vis="0";
                fund.name=data[i][0].name; //fetch name
                fundName[i]=fund.name; //put the name in array
                fund.priceList=new Array();
                var fundData = new Array();
                fundData=data[i][1].data; //fetch each day+prices elements
                for(var j=0;j<fundData.length;j++){
                    var dailyPrice=new Object();
                    dailyPrice.tot=parseFloat(fundData[j].tot);
                    dailyPrice.add=parseFloat(fundData[j].add);
                    dailyPrice.rem=parseFloat(fundData[j].rem);
                    dailyPrice.diff=parseFloat(fundData[j].diff);
                    var Str=fundData[j].date;

                    //construct the map for mapping date to array index
                    //only do it once for first series is okay
                    if(i==0){
                        DateMapIndex.set(Str,j);
                    }

                    dailyPrice.date=parseDate(Str);
                    fund.priceList[j]=dailyPrice;
                    vectorVis[i] = 0;
                }
                dataSet[i]=fund;
            }
            if (start == 1) {
                start = 0;
                var hash = window.location.hash.substr(1); //hash parse
                var rand = hashName[hash] || Math.floor(Math.random()*(data.length)); //generate random number
                dataSet[rand].vis = "1"; //random set vis
                vectorVis[rand] = 1;
            } else {
                for (key in vectorVis) {
                    if (vectorVis[key] == 1 && vectorVis[key] != undefined) {
                        dataSet[key].vis = "1";
                    }
                }
            }
        },
        error: function(jqHXR, textStatus, errorThrown) {
            console.log('ajax error in get survey ID call:' +textStatus + ' ' + errorThrown);
        }
    });
}