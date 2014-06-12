<?php
header('Content-type: application/json');
header('Cache-Control: no-cache');

$file = 'lavoro_sporco.csv';

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
          $arr[$j-1][1]['data'][$i-1]['month'] = (int)substr($lineArray[0],4,2);
          $arr[$j-1][1]['data'][$i-1]['year'] = (int)substr($lineArray[0],0,4);
          $arr[$j-1][1]['data'][$i-1]['day'] = (int)substr($lineArray[0],6,2);
		  $arr[$j-1][1]['data'][$i-1]['tot'] = $lineArray[$j];
        }
      }
    }
  $i++;
  }
  fclose($handle);
}

$file = 'diff.csv';

if (($handle = fopen($file, 'r')) !== FALSE) {
  fgetcsv($handle); // remove first line
  $i = 1;
  while ($i < 5) { // offset
    $z = 0;
    for ($j = 0; $j < 24; $j++) {
      $arr[$z][1]['data'][$i-1]['add'] = (string)0;
      $arr[$z][1]['data'][$i-1]['rem'] = (string)0;
      $arr[$z][1]['data'][$i-1]['diff'] = (string)0;
      $z++;
	}
    $i++;
  }
  while (($lineArray = fgetcsv($handle)) !== FALSE) {
    $z = 0;
    for ($j = 0; $j < count($lineArray); $j++) {
      if ($j % 2) {
        $arr[$z][1]['data'][$i-1]['add'] = $lineArray[$j];
        $arr[$z][1]['data'][$i-1]['rem'] = $lineArray[$j+1];
        $arr[$z][1]['data'][$i-1]['diff'] = (string)($lineArray[$j] - $lineArray[$j+1]);
        $z++;
      }
	}
    $i++;
  }
  fclose($handle);
}

echo json_encode($arr);

?>
