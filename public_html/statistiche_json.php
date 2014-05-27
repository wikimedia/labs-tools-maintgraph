<?php
header('Content-type: application/json');
header('Cache-Control: no-cache');

$file = 'stats/statistiche.csv';

if (($handle = fopen($file, 'r')) !== FALSE) { 
  $i = 0; 
  while (($lineArray = fgetcsv($handle)) !== FALSE) { 
    for ($j = 0; $j < count($lineArray); $j++) {
      if ($i == 0) {
        if ($j > 0) {
          $arr[$j-1][0]['name'] = $lineArray[$j];
        }
      } else {
        if ($j > 0) {
          $arr[$j-1][1]['data'][$i-1]['price'] = $lineArray[$j];
          $arr[$j-1][1]['data'][$i-1]['month'] = (int)substr($lineArray[0],4,2);
          $arr[$j-1][1]['data'][$i-1]['year'] = (int)substr($lineArray[0],0,4);
          $arr[$j-1][1]['data'][$i-1]['day'] = (int)substr($lineArray[0],6,2);
        }
      }
    } 
  $i++; 
  } 
  fclose($handle); 
} 

echo json_encode($arr);

?>