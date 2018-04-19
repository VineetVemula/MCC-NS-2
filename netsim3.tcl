#Create Simulator object
set ns [new Simulator]

#Define different colors for data flow
$ns color 1 Blue
$ns color 2 Red

#Open Event tracefiles
set file1 [open out.tr w]
$ns trace-all $file1

#Open NAM Trace File
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

#Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
 
#Create links between nodes
$ns duplex-link $n0 $n1 0.5Mb 30ms DropTail
$ns duplex-link $n1 $n2 0.5Mb 30ms DropTail
$ns duplex-link $n2 $n3 0.5Mb 30ms DropTail
$ns duplex-link $n3 $n4 0.5Mb 30ms DropTail
$ns duplex-link $n4 $n5 0.3Mb 30ms DropTail
$ns duplex-link $n5 $n0 0.3Mb 30ms DropTail

#Give Node Position (for NAM)
$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n1 $n2 orient down
$ns duplex-link-op $n2 $n3 orient left-down
$ns duplex-link-op $n3 $n4 orient left-up
$ns duplex-link-op $n4 $n5 orient up
$ns duplex-link-op $n5 $n0 orient right-up

#Set Queue size of link (n2-n3)
#$ns queue-limit $n2 $n3 40

#setup TCP connection
set tcp [new Agent/TCP]
$ns attach-agent $n3 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n5 $sink
$ns connect $tcp $sink
$tcp set fid_ 1
$tcp set window_ 8000
$tcp set packetSize_ 552

#Setup FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp

#Setup UDP connection
set udp [new Agent/UDP]
$ns attach-agent $n3 $udp
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
$ns at 1.0 "$ftp start"
$ns at 624.0 "$cbr stop"
$ns at 624.5 "$ftp stop"

#Call finish procedure
$ns at 625.0 "finish"

#Run simulator
$ns run
