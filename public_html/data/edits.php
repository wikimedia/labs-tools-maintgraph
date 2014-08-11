<?php
header('Content-type: application/json');
header('Cache-Control: no-cache');
$file = 'edits.csv';

if (($handle = fopen($file, 'r')) !== FALSE) {
    $i = 0;
    while (($lineArray = fgetcsv($handle)) !== FALSE) {
        if ($i == 0) {
            $arr[0][0]['name'] = $lineArray[1];
        }
        else {
            if ($i == 1) {
                $prevLine = $lineArray;
            }
            else {
                $arr[0][1]['data'][$i - 2]['date'] = $lineArray[0];
                $arr[0][1]['data'][$i - 2]['tot'] = $lineArray[1];
                $arr[0][1]['data'][$i - 2]['diff'] = (string)($lineArray[1] - $prevLine[1]);
            }
        }

        if ($i == 0) {
            $arr[1][0]['name'] = $lineArray[2];
        }
        else {
            if ($i == 1) {
                $prevLine = $lineArray;
            }
            else {
                $arr[1][1]['data'][$i - 2]['date'] = $lineArray[0];
                $arr[1][1]['data'][$i - 2]['tot'] = $lineArray[2];
                $arr[1][1]['data'][$i - 2]['diff'] = (string)($lineArray[2] - $prevLine[2]);
            }
        }

        if ($i == 0) {
            $arr[2][0]['name'] = $lineArray[4];
        }
        else {
            if ($i == 1) {
                $prevLine = $lineArray;
            }
            else {
                $arr[2][1]['data'][$i - 2]['date'] = $lineArray[0];
                $arr[2][1]['data'][$i - 2]['tot'] = $lineArray[4];
                $arr[2][1]['data'][$i - 2]['diff'] = (string)($lineArray[4] - $prevLine[4]);
            }
        }

        if ($i == 0) {
            $arr[3][0]['name'] = 'Edit utenti registrati';
        }
        else {
            if ($i == 1) {
                $prevLine = $lineArray;
            }
            else {
                $arr[3][1]['data'][$i - 2]['date'] = $lineArray[0];
                $arr[3][1]['data'][$i - 2]['tot'] = (string)($lineArray[1] - $lineArray[3] - $lineArray[5]);
                $arr[3][1]['data'][$i - 2]['diff'] = (string)($lineArray[1] - $lineArray[3] - $lineArray[5] - ($prevLine[1] - $prevLine[3] - $prevLine[5]));
            }
        }

        if ($i == 0) {
            $arr[4][0]['name'] = 'Edit utenti anonimi';
        }
        else {
            if ($i == 1) {
                $prevLine = $lineArray;
            }
            else {
                $arr[4][1]['data'][$i - 2]['date'] = $lineArray[0];
                $arr[4][1]['data'][$i - 2]['tot'] = $lineArray[3];
                $arr[4][1]['data'][$i - 2]['diff'] = (string)($lineArray[3] - $prevLine[3]);
            }
        }

        if ($i == 0) {
            $arr[5][0]['name'] = $lineArray[5];
        }
        else {
            if ($i == 1) {
                $prevLine = $lineArray;
            }
            else {
                $arr[5][1]['data'][$i - 2]['date'] = $lineArray[0];
                $arr[5][1]['data'][$i - 2]['tot'] = $lineArray[5];
                $arr[5][1]['data'][$i - 2]['diff'] = (string)($lineArray[5] - $prevLine[5]);
                $prevLine = $lineArray;
            }
        }

        $i++;
    }

    fclose($handle);
}

echo json_encode($arr);
?>