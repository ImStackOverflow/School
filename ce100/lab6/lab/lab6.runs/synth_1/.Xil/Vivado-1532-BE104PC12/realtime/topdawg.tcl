# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "C:/Users/ghchen/Desktop/lab6/lab6.runs/synth_1/.Xil/Vivado-1532-BE104PC12/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7a35tcpg236-1

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common.tcl
    set rt::defaultWorkLibName xil_defaultlib

    # Skipping read_* RTL commands because this is post-elab optimize flow
    set rt::useElabCache true
    if {$rt::useElabCache == false} {
      rt::read_verilog {
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/imports/Desktop/fux4to1.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/imports/Desktop/countUD4L.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/imports/Desktop/fux8to1.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/imports/Desktop/edgeD.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/new/TIMEBITCH.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/imports/Desktop/lab6_clks.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/imports/Desktop/selector.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/new/fuckingsteak.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/new/score.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/imports/Desktop/ringcounter.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/new/countTIME.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/imports/Desktop/hex7seg.v
      C:/Users/ghchen/Desktop/lab6/lab6.srcs/sources_1/new/topdawg.v
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification true
    set rt::SDCFileList C:/Users/ghchen/Desktop/lab6/lab6.runs/synth_1/.Xil/Vivado-1532-BE104PC12/realtime/topdawg_synth.xdc
    rt::sdcChecksum
    set rt::top topdawg
    set rt::reportTiming false
    rt::set_parameter elaborateOnly false
    rt::set_parameter elaborateRtl false
    rt::set_parameter eliminateRedundantBitOperator true
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter ramStyle auto
    rt::set_parameter merge_flipflops true
# MODE: 
    rt::set_parameter webTalkPath {C:/Users/ghchen/Desktop/lab6/lab6.cache/wt}
    rt::set_parameter enableSplitFlowPath "C:/Users/ghchen/Desktop/lab6/lab6.runs/synth_1/.Xil/Vivado-1532-BE104PC12/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
      rt::run_synthesis -module $rt::top
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    rt::HARTNDb_reportJobStats "Synthesis Optimization Runtime"
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }


  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  rt::set_parameter helper_shm_key "" 
    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
