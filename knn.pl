#!/usr/bin/perl -w
#Algorithm to classify data into two classes using K nearest neighbors
#Author : Kranthi K. Pamarthi
#Parameters : Two classes, stressed and not stressed. H and W as axes
# Where H is Husband and W is Wife
print "Begin K nearest neigbors classification\n";
chomp($k = 30);
knn ();
####################################################
############### KNN algo ###########################
####################################################
sub knn
 {
     open (STRESSH,stress_H) || die "cannot access the file : $!\n";
     open (STRESSW,stress_W) || die "cannot access the file : $!\n";
     open (NSTRESSH,nstress_H) || die "cannot access the file : $!\n";
     open (NSTRESSW,nstress_W) || die "cannot access the file : $!\n";
     open (DATAOUT,">test_data.txt") || die "cannot create file :$!\n";
     open (STRESSOUT,">stress_data.txt") || die "cannot create file :$!\n";
     open (NSTRESSOUT,">nstress_data.txt") || die "cannot create file :$!\n";
     print "Accessing the stress class Husband points\n";
     while (<STRESSH>)
     {
	 push @S_H, "$_";
     }
     close (STRESSH);
     print "Accessing the stress class Wife points\n";
     while (<STRESSW>)
     {
	 push @S_W, "$_";
     }
     close (STRESSW);
     print "Accessing the non stress class Husband points\n";
     while (<NSTRESSH>)
     {
	 push @N_H, "$_";
     }
     close (NSTRESSH);
     print "Accessing the non stress class Wife points\n";
     while (<NSTRESSW>)
     {
	 push @N_W, "$_";
     }
     close (NSTRESSW);
     #print "@S_H\n\n @S_W\n\n @N_H\n\n @N_W\n\n";
     #Initializing points
     for ($i=0;$i<201;$i++)
     {
	 $stress{$S_W[$i]} = $S_H[$i];
         #print "$S_W[$i] $stress{$S_W[$i]}\n";
     }
     for ($j=0;$j<200;$j++)
     {
	 $nstress{$N_W[$j]} = $N_H[$j];
         #print "$N_W[$j] $nstress{$N_W[$j]}\n";
     }
     #data classification
     chomp ($t = 1);
     for ($t=1;$t<6281001;$t++)
     {
	 print "iteration : $t\n";
     $l = $t-1; 
     $wrange = 25;
     $hrange = 25;
     $tw = rand($wrange);
     #$twlb = int($tw)-1;
     #$twhb = $twlb+3;
     $th = rand($hrange);
     #$thlb = int($th)-1;
     #$thhb = $thlb+3;
     push @W,"$tw";
     push @H,"$th";
     $data{$W[$l]} = $H[$l];
     print DATAOUT "$W[$l] $data{$W[$l]}\n";
     print "random pair are $tw and $th\n";
     #foreach $i(@N_W)
     #{
       #if (($twlb <= $i) && ($i <= $twhb))
       #{
	#   push @twn, "$i";
      # }
     #}
     #foreach $j(@twn)
     #{
       #if (($thlb <= $nstress{$j}) && ($nstress{$j} <= $thhb))
       #{
	#   push @twnf, "$j";
       #}
     #}
     #$kn = @twnf; #number of unstressed pairs around
     #print "The number of unstressed pairs around $W[$k], $data{$W[$k]} are $kn\n";
     #foreach $i(@S_W)
     #{
       #if (($twlb <= $i) && ($i <= $twhb))
       #{
	  # push @tws, "$i";
       #}
     #}
     #foreach $j(@tws)
     #{
       #if (($thlb <= $stress{$j}) && ($stress{$j} <= $thhb))
       #{
	 #  push @twsf, "$j";
       #}
     #}
     #$ks = @twsf; #number of stressed pairs around
     #print "The number of stressed pairs around $W[$k], $data{$W[$k]} are $ks\n";
     #if ($ks >= $kn)
     #{
	# $class = 1;
         #print "The pair $tw $th belongs to stressed class\n";
         #print STRESSOUT "$W[$k] $data{$W[$k]}\n";
     #}
     #else
     #{
        # $class = 0;
        # print "The pair $tw $th belongs to unstressed class\n";
        # print NSTRESSOUT "$W[$k] $data{$W[$k]}\n";
     #}
     #}
     for ($i=0;$i<200;$i++)
     {
	 $tempnW = ($tw - $N_W[$i])*($tw - $N_W[$i]);
         $tempnH = ($th - $N_H[$i])*($th - $N_H[$i]);
         $tempn = $tempnW + $tempnH;
	 $nd[$i] = sqrt($tempn);
     }
     @ndf = sort(@nd);
     for ($i=0;$i<201;$i++)
     {
	 $tempsW = ($tw-$S_W[$i])*($tw-$S_W[$i]);
         $tempsH = ($th-$S_H[$i])*($th-$S_H[$i]);
         $temsp = $tempsW + $tempsH;
	 $sd[$i] = sqrt($temsp);
     }
     @sdf = sort(@sd);
     if ($sdf[$k] >= $ndf[$k])
     {
         print "The random pair $tw and $th belongs to stressed class\n";
         $class = 1;
         print STRESSOUT "$W[$l] $data{$W[$l]}\n";
     }
     else
     {
         print "The random pair $tw and $th belongs to unstressed class\n";
         $class = 0;
         print NSTRESSOUT "$W[$l] $data{$W[$l]}\n";
     }
     }
     close (STRESSOUT);
     close (NSTRESSOUT);
     close (DATAOUT);
     print "The file test_data.txt is printed\n";
     print "The file stress_data.txt is printed\n";
     print "The file nstress_data.txt is printed\n\n";
 }
 
