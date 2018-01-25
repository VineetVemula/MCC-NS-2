#Create Simulator object
set ns [new Simulator]
#Define different colors for data flow
$ns color 1 Blue
$ns color 2 Red
#open Event trace files
set file1 [open out.tr w]
$ns trace-all $file1
#open NAM trace file
set file2 [open out.nam w]
$ns namtrace-all $file2
#Define finish procedure
proc finish {} {
global ns file1 file2
$ns flush-trace
close $file1
close $file2
exec nam out.nam &
exit 0}
#Create link between nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
#Create link between nodes
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 0.3Mb 100ms DropTail
$ns duplex-link $n3 $n2 0.3Mb 100ms DropTail
$ns duplex-link $n3 $n4 0.5Mb 30ms DropTail
$ns duplex-link $n3 $n5 0.5Mb 30ms DropTail
#Give Node Position (for NAM)
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient left
$ns duplex-link-op $n3 $n2 orient right
$ns duplex-link-op $n3 $n4 orient right-up
$ns duplex-link-op $n3 $n5 orient right-down
#Set Queue size of link (n2-n3)
$ns queue-limit $n2 $n3 40
#Setup TCP connection
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink
$ns connect $tcp $sink
$tcp set fid_ 1
$tcp set window_ 8000
$tcp set packetSize_ 552
#setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp

#Setup UDP connection
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n5 $null
$ns connect $udp $null
$udp set fid_ 2

#Setup cbr over udp connection
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetSize_ 1000
$cbr set rate_ 0.01Mb

#Scheduling events
$ns at 0.1 "$cbr start"
$ns at 0.1 "$ftp start"
$ns at 624.0 "$cbr stop"
$ns at 624.5 "$ftp stop"

#Call finish procedure
$ns at 625 "finish"
#Run simulator
$ns run
