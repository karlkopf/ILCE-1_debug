#!/bin/bash

# some simple tests for the ILCE-1

_result_dir="/root/cp/ilce-1/results"

if [[ ! -d ${_result_dir} ]]; then
  mkdir -p ${_result_dir}
fi

_gphoto2_bin=$(command -v gphoto2)

_test_case=${1}

_datestring="$(date "+%Y-%m-%d_%H.%M.%S")"
_download_image="${_result_dir}/${_datestring}_capture-image-and-download.jpg"
_preview_image="${_result_dir}/${_datestring}_capture-preview.jpg"
_sdram_image="${_result_dir}/${_datestring}_wait-event-and-download.jpg"
_tethered_image="${_result_dir}/${_datestring}_tethered.jpg"

_get_summary() {
  local _result
  local _debug_logfile
  _result="${_result_dir}/${_datestring}_${_test_case}_summary.txt"
  _debug_logfile="${_result_dir}/${_datestring}_${_test_case}_summary_debug.txt"

  env LANG=C \
    ${_gphoto2_bin} \
      --debug \
      --debug-logfile="${_debug_logfile}" \
      --summary \
    >>${_result} 2>&1
}

_get_config_output() {
  local _result
  local _debug_logfile
  _result="${_result_dir}/${_datestring}_${_test_case}_list-all-config_1.txt"
  _debug_logfile="${_result_dir}/${_datestring}_${_test_case}_list-all-config_1_debug.txt"

  env LANG=C \
    ${_gphoto2_bin} \
      --debug \
      --debug-logfile="${_debug_logfile}" \
      --list-all-config \
    >>${_result} 2>&1
}

_get_config_output_after() {
  local _result
  local _debug_logfile
  _result="${_result_dir}/${_datestring}_${_test_case}_list-all-config_2.txt"
  _debug_logfile="${_result_dir}/${_datestring}_${_test_case}_list-all-config_2_debug.txt"

  env LANG=C \
    ${_gphoto2_bin} \
      --debug \
      --debug-logfile="${_debug_logfile}" \
      --list-all-config \
    >>${_result} 2>&1
}

_capture_and_download() {
  local _result
  local _debug_logfile
  _result="${_result_dir}/${_datestring}_${_test_case}_capture-image-and-download.txt"
  _debug_logfile="${_result_dir}/${_datestring}_${_test_case}_capture-image-and-download_debug.txt"

  env LANG=C \
    ${_gphoto2_bin} \
      --debug \
      --debug-logfile="${_debug_logfile}" \
      --capture-image-and-download \
      --filename="${_download_image}" \
    >>${_result} 2>&1
}

_capture_preview() {
  local _result
  local _debug_logfile
  _result="${_result_dir}/${_datestring}_${_test_case}_capture-preview.txt"
  _debug_logfile="${_result_dir}/${_datestring}_${_test_case}_capture-preview_debug.txt"

  env LANG=C \
    ${_gphoto2_bin} \
      --debug \
      --debug-logfile="${_debug_logfile}" \
      --capture-preview \
      --filename="${_preview_image}" \
    >>${_result} 2>&1
}

_get_storage_info() {
  local _result
  local _debug_logfile
  _result="${_result_dir}/${_datestring}_${_test_case}_storage-info.txt"
  _debug_logfile="${_result_dir}/${_datestring}_${_test_case}_storage-info_debug.txt"

  env LANG=C \
    ${_gphoto2_bin} \
      --debug \
      --debug-logfile="${_debug_logfile}" \
      --storage-info \
    >>${_result} 2>&1
}

_get_sdcard() {
  local _result
  local _debug_logfile
  _result="${_result_dir}/${_datestring}_${_test_case}_list-files-and-folders.txt"
  _debug_logfile="${_result_dir}/${_datestring}_${_test_case}_list-files-and-folders_debug.txt"

  env LANG=C \
    ${_gphoto2_bin} \
      --debug \
      --debug-logfile="${_debug_logfile}" \
      -lLR \
    >>${_result} 2>&1
}

_set_shutter_speed() {
  local _result
  local _debug_logfile
  local _speed
  _result="${_result_dir}/${_datestring}_${_test_case}_set-shutterspeed.txt"
  _debug_logfile="${_result_dir}/${_datestring}_${_test_case}_set-shutterspeed_debug.txt"
  _speed=$(shuf -i 30-40 | tail -1)

  env LANG=C \
    ${_gphoto2_bin} \
      --debug \
      --debug-logfile="${_debug_logfile}" \
      --set-config shutterspeed=${_speed} \
    >>${_result} 2>&1
}

_wait_event_and_download() {
  local _result
  local _debug_logfile
  _result="${_result_dir}/${_datestring}_${_test_case}_wait-event-and-download.txt"
  _debug_logfile="${_result_dir}/${_datestring}_${_test_case}_wait-event-and-download_debug.txt"

  env LANG=C \
    ${_gphoto2_bin} \
      --debug \
      --debug-logfile="${_debug_logfile}" \
      --wait-event-and-download=1 \
      --filename="${_sdram_image}" \
    >>${_result} 2>&1
}

_capture_tethered() {
  local _result
  local _debug_logfile
  _result="${_result_dir}/${_datestring}_${_test_case}_capture-tethered.txt"
  _debug_logfile="${_result_dir}/${_datestring}_${_test_case}_capture-tethered_debug.txt"

  env LANG=C \
    ${_gphoto2_bin} \
      --debug \
      --debug-logfile="${_debug_logfile}" \
      --capture-tethered \
      --filename="${_tethered_image}" \
    >>${_result} 2>&1
}

_main() {
  _get_summary
  _get_config_output
  _capture_and_download
  _capture_preview
  _get_storage_info
  _get_sdcard
  _set_shutter_speed
  _wait_event_and_download
  #_capture_tethered
  _get_config_output_after
}

_main
