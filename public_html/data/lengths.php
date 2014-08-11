<?php
header('Content-type: application/json');
header('Cache-Control: no-cache');
$file = 'lengths.csv';

if (($handle = fopen($file, 'r')) !== FALSE) {
    $i = 0;
    while (($lineArray = fgetcsv($handle)) !== FALSE) {
        for ($j = 0; $j < count($lineArray); $j++) {
            if ($i == 0) {
                if ($j > 0) {
                    $arr[$j - 1][0]['name'] = $lineArray[$j];
                }
            }
            else {
                if ($j > 0) {
                    if ($i == 1) {
                        $prevLine = $lineArray;
                    }
                    else {
                        $arr[$j - 1][1]['data'][$i - 2]['date'] = $lineArray[0];
                        $arr[$j - 1][1]['data'][$i - 2]['tot'] = $lineArray[$j];
                        $arr[$j - 1][1]['data'][$i - 2]['diff'] = (string)($lineArray[$j] - $prevLine[$j]);
                        if ($j == (count($lineArray) - 1)) $prevLine = $lineArray;
                    }
                }
            }
        }

        $i++;
    }

    fclose($handle);
}

echo json_encode($arr);
?>