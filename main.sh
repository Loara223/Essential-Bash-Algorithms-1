MFT (){
declare -a mp[10]
tif=0
p=0

echo -e "\nEnter the toatl memory available (in Bytes)-- "
read ms
echo -e "\nEnter the block size (in Bytes) -- "
read bs
nob=$((ms/bs))
ef=$((ms - $((nob*bs))))
echo -e "\nEnter the number of processes -- " 
read n 

i=0
while [ $i -lt $n ]
do 
echo -e "Enter memory required for process $((i+1)) (in Bytes)-- "
read mp[$i]
i=$((i+1))
done 
echo -e "\nNo. of Blocks available in memory -- $nob"
echo -e "\n\nPROCESS\tMEMORY_REQUIRED\tALLOCATED\tINTERNAL_FRAGMENTATION"

i=0
while [ $i -lt $n -a $p -lt $nob ]
do

if [ $((mp[$i])) -gt $bs ]
then 
echo -e "\n$(($i+1))\t\t$((mp[$i]))\t\t\t\tNO\t\t\t ---"
else
echo -e "\n$(($i+1))\t\t$((mp[$i]))\t\t\t\tYES\t\t\t $((bs-mp[$i]))" 
tif=$((tif + bs-mp[$i]))

p=$((p+1)) 
fi 

i=$((i+1))
done

if [ $i -lt $n ]
then
echo -e "\nMemory is Full, Remaining Processes cannot be accomodated"
fi 
echo -e "\n\nTotal Internal Fragmentation is $tif "
echo -e "\nTotal External Fragmentation is $ef "
}

MVT (){
declare -a mp[10]
n=0
ch='y'

echo -e "\nEnter the toatl memory available (in Bytes)-- "
read ms
temp=$ms

i=0
while [ $ch == y ] 
do
echo -e "\nEnter memory required for process [$(($i+1))]: "
read mp[i]

if [ $((mp[i])) -le $temp ]
then
echo -e "\nMemory is allocated for Process $(($i+1))"
temp=$(($temp - $((mp[i]))))
else
echo -e "\nMemory is Full"
break
fi 

echo -e "\nDo you want to continue?(y/n)--\t"
read ch
i=$((i+1))
n=$((n+1))
done 

echo -e "\n\nTotal Memory Available-- $ms"
echo -e "\n\nPROCESS\t\tMEMORY ALLOCATED"
i=0
while [ $i -lt $n ]
do
echo -e "\n$(($i+1))\t\t\t$((mp[i]))"
i=$((i+1))
done

echo -e "\n\nTotal Memory Allocated is $(($ms-$temp))"
echo -e "\nTotal External Fragmentation is $temp" 
}

FCFS () {
declare -a p[20]
declare -a bt[20] 
declare -a wt[20]
declare -a tat[20]

echo "Enter the Number of Processes:"
read n 
i=0 
while [ $i -lt $n ]
do 
p[i]=$i
echo "Enter the burst time P$i process "
read bt[$i] 
i=$((i+1))
done  

wt[0]=0
tat[0]=$((bt[0])) 
wtavg=$((wt[0]))
tatavg=$((tat[0]))

i=1
while [ $i -lt $n ]
do 

wt[i]=$((tat[$i-1]))
tat[i]=$(($((wt[$i])) + $((bt[$i]))))
wtavg=$((wtavg + wt[$i]))
tatavg=$((tatavg + tat[$i]))
i=$((i+1))
done  

echo -e "\n\nProcess\tBurstTime\tWaitingTime\tTurnAroundT"

i=0
while [ $i -lt $n ]       
do 
echo -e  "\n$((p[$i]))\t\t\t$((bt[$i]))\t\t\t$((wt[$i]))\t\t\t$((tat[$i]))"
i=$((i+1))
done 

res1="$((wtavg/$n)).$(((wtavg*100/$n)%100))"
res2="$((tatavg/$n)).$(((tatavg*100/$n)%100))"

echo "Average Waiting Time:" 
echo $res1
echo "Average Turnaround Time :" 
echo $res2
}

SJF () {
declare -a p[20]
declare -a bt[20] 
declare -a wt[20]
declare -a tat[20]

echo "Enter the Number of Processes:"
read n 
i=0 
while [ $i -lt $n ]
do 
p[i]=$i
echo "Enter the burst time P$i process "
read bt[$i] 
i=$((i+1))
done  

i=0 
while [ $i -lt $n ]
do
k=$((i+1))
while [ $k -lt $n ]
do 
if [ $((bt[i])) -gt $((bt[k])) ]
then

temp=$((p[$i]))
p[i]=$((p[$k]))
p[k]=$temp

temp=$((bt[$i]))
bt[i]=$((bt[$k]))
bt[k]=$temp 

fi 
k=$((k+1))
done 
i=$((i+1))
done 
wt[0]=0
tat[0]=$((bt[0])) 
wtavg=$((wt[0]))
tatavg=$((tat[0]))

i=1
while [ $i -lt $n ]
do 

wt[i]=$((tat[$i-1]))
tat[i]=$(($((wt[$i])) + $((bt[$i]))))
wtavg=$((wtavg + wt[$i]))
tatavg=$((tatavg + tat[$i]))
i=$((i+1))
done 
 
echo -e "\n\nProcess\tBurstTime\tWaitingTime\tTurnAroundT"

i=0
while [ $i -lt $n ]       
do 
echo -e  "\n$((p[$i]))\t\t\t$((bt[$i]))\t\t\t$((wt[$i]))\t\t\t$((tat[$i]))"
i=$((i+1))
done 

res1="$((wtavg/$n)).$(((wtavg*100/$n)%100))"
res2="$((tatavg/$n)).$(((tatavg*100/$n)%100))"

echo "Average Waiting Time:" 
echo $res1
echo "Average Turnaround Time :" 
echo $res2
}

PRIORITY () {
declare -a p[20]
declare -a bt[20] 
declare -a wt[20]
declare -a tat[20]
declare -a pri[20]

echo "Enter the Number of Processes:"
read n 
i=0 
while [ $i -lt $n ]
do 
p[i]=$i
echo "Enter the burst time & Priority P$i process "
read bt[$i] 
read pri[$i]
i=$((i+1))
done  

i=0 
while [ $i -lt $n ]
do
k=$((i+1))
while [ $k -lt $n ]
do 
if [ $((pri[i])) -gt $((pri[k])) ]
then

temp=$((p[$i]))
p[i]=$((p[$k]))
p[k]=$temp

temp=$((bt[$i]))
bt[i]=$((bt[$k]))
bt[k]=$temp 

temp=$((pri[$i]))
pri[i]=$((pri[$k]))
pri[k]=$temp 

fi 
k=$((k+1))
done 
i=$((i+1))
done 
wt[0]=0
tat[0]=$((bt[0])) 
wtavg=$((wt[0]))
tatavg=$((tat[0]))

i=1
while [ $i -lt $n ]
do 

wt[i]=$((tat[$i-1]))
tat[i]=$(($((wt[$i])) + $((bt[$i]))))
wtavg=$((wtavg + wt[$i]))
tatavg=$((tatavg + tat[$i]))
i=$((i+1))
done 

echo -e "\n\nProcess\tBurstTime\tPriority\tWaitingTime\tTurnAroundT"

i=0
while [ $i -lt $n ]       
do 
echo -e  "\n$((p[$i]))\t\t\t$((bt[$i]))\t\t\t$((pri[$i]))\t\t\t$((wt[$i]))\t\t\t$((tat[$i]))"
i=$((i+1))
done 

res1="$((wtavg/$n)).$(((wtavg*100/$n)%100))"
res2="$((tatavg/$n)).$(((tatavg*100/$n)%100))"

echo "Average Waiting Time:" 
echo $res1
echo "Average Turnaround Time :" 
echo $res2
}


echo -e "\n\n----------Welcome to Bash Script Programming---------"
while true; 
do 
echo -e "\nWhich operation do you want?\n"
echo -e "\t\tEnter 1 for call Calculator."
echo -e "\t\tEnter 2 for Memory Management Techniques. "
echo -e "\t\tEnter 3 CPU Scheduling Algorithm."
echo -e "\t\tEnter 4 for Contigeous Memory Allocation Technique"
echo -e "\t\tEnter 0 for Exit."
read operation

if [ $operation -eq 1 ]
then 
echo -e "\nWhich operation do you want?\n"
echo -e "\t\tEnter 1 for Addition."
echo -e "\t\tEnter 2 for Subtraction."
echo -e "\t\tEnter 3 for Multiplication."
echo -e "\t\tEnter 4 for Division."
echo -e "\t\tEnter 5 for Modulus."

read op1

case $op1 in
1)
total=0
k=0
echo -e "\nEnter the number of elements you want to add:"
read n
echo -e "Please enter $n numbers one by one: \n"
while [ $k -lt $n ]
do 
read number
total=$((total+number))
k=$((k+1))
done 
echo -e "Sum of $n numbers = $total \n"
;;

2)

c=0
echo -e "\nPlease enter first number  : "
read a
echo -e "Please enter second number : "
read b
c=$((a-b))
echo -e "\nSubtraction is: $c"
;;

3)

mul=0
echo -e "\nPlease enter first number: "
read a
echo -e "Please enter second number: "
read b
mul=$((a*b))
echo -e "\nMultiplication of entered numbers = $mul"
;;

4)
d=0
echo -e "\nPlease enter first number  : "
read a
echo -e "Please enter second number : "
read b
d=$((a/b))
echo -e "\nDivision of entered numbers= $d\n"
;;

5)
d=0
echo -e "\nPlease enter first number   : "
read a
echo -e "Please enter second number  : "
read b
d=$((a%b))
echo -e "\nModulus of entered numbers = $d\n"
;;

*)
echo "Invalid operation"
;;
esac

elif [ $operation -eq 2 ]
then 
echo -e "\nWhich operation do you want?\n"
echo -e "\t\tEnter 1 for Multiprogramming with a Fixed number of Tasks."
echo -e "\t\tEnter 2 for Multiprogramming with a Variable number of Tasks"
read op2

case $op2 in 
1)
MFT 
;;
2)
MVT
;;
*)
echo "You enter Invalid number------"
;;
esac


elif [ $operation -eq 3 ]
then 
echo -e "\nWhich operation do you want?\n"
echo -e "\t\tEnter 1 First-Come-First-Serve Scheduling Algorithm."
echo -e "\t\tEnter 2 Shortest-Job-First Scheduling Algorithm."
echo -e "\t\tEnter 3 Priority Scheduling Algorithm."
echo -e "\t\tEnter 4 Scheduling Algorithm using (Priority>SJF>FCFS)."
read op3

case $op3 in 
1) 
FCFS 
;;

2)
SJF 
;;

3)
PRIORITY 
;;

4) 

declare -a p[20]
declare -a bt[20] 
declare -a wt[20]
declare -a tat[20]
declare -a pri[20]

echo "Enter the Number of Processes:"
read n 
i=0 
while [ $i -lt $n ]
do 
p[i]=$i
echo "Enter the burst time & Priority P$i process "
read bt[$i] 
read pri[$i]
i=$((i+1))
done  

i=0 
while [ $i -lt $n ]
do
k=$((i+1))
while [ $k -lt $n ]
do 
if [ $((pri[i])) -gt $((pri[k])) ]
then

temp=$((p[$i]))
p[i]=$((p[$k]))
p[k]=$temp

temp=$((bt[$i]))
bt[i]=$((bt[$k]))
bt[k]=$temp 

temp=$((pri[$i]))
pri[i]=$((pri[$k]))
pri[k]=$temp 

elif [ $((pri[i])) -eq $((pri[k])) -a  $((bt[i])) -gt $((bt[k])) ]
then 
temp=$((bt[$i]))
bt[i]=$((bt[$k]))
bt[k]=$temp 

temp=$((pri[$i]))
pri[i]=$((pri[$k]))
pri[k]=$temp 

temp=$((p[$i]))
p[i]=$((p[$k]))
p[k]=$temp

elif [ $((pri[i])) -eq $((pri[k])) -a  $((bt[i])) -eq $((bt[k])) -a $((p[i])) -gt $((p[k]))  ]
then  
temp=$((p[$i]))
p[i]=$((p[$k]))
p[k]=$temp

temp=$((bt[$i]))
bt[i]=$((bt[$k]))
bt[k]=$temp 

temp=$((pri[$i]))
pri[i]=$((pri[$k]))
pri[k]=$temp 
fi  
k=$((k+1))
done 
i=$((i+1))
done 
wt[0]=0
tat[0]=$((bt[0])) 
wtavg=$((wt[0]))
tatavg=$((tat[0]))

i=1
while [ $i -lt $n ]
do 

wt[i]=$((tat[$i-1]))
tat[i]=$(($((wt[$i])) + $((bt[$i]))))
wtavg=$((wtavg + wt[$i]))
tatavg=$((tatavg + tat[$i]))
i=$((i+1))
done 

echo -e "\nProcess\tBurstTime\tPriority\tWaitingTime\tTurnAroundT"

i=0
while [ $i -lt $n ]       
do 
echo -e "\n$((p[$i]))\t\t\t$((bt[$i]))\t\t\t $((pri[$i]))\t\t\t$((wt[$i]))\t\t\t$((tat[$i]))"
i=$((i+1))
done 

res1="$((wtavg/$n)).$(((wtavg*100/$n)%100))"
res2="$((tatavg/$n)).$(((tatavg*100/$n)%100))"

echo "Average Waiting Time:" 
echo $res1
echo "Average Turnaround Time :" 
echo $res2
;;

*)
echo "You enter Invalid number------"
;;
esac 


elif [ $operation -eq 4 ]
then 
echo -e "\nWhich operation do you want?\n"
echo -e "\t\tEnter 1 Worst-Fit Memory Allocation Technique."
echo -e "\t\tEnter 2 Best-Fit Memory Allocation Technique."
echo -e "\t\tEnter 3 First-Fit Memory Allocation Technique."
read op4

case $op4 in  
1) 
declare -a p[20] 
declare -a b[20]
declare -a f[20]

r=0
echo "Enter the number of block: "
read n 
echo -e "\nEnter the number of file: "
read m 

i=0
while [ $i -lt $n ]
do 
echo -e "\nEnter block size $i: "
read b[$i]
i=$((i+1))
done 

i=0
while [ $i -lt $m ] 
do 
echo -e "\nEnter file size $i: "
read f[$i]
i=$((i+1))
done 

i=0
while [ $i -lt $n ]
do 
k=$((i+1))
while [ $k -lt $n ]
do
if [ $((b[$i])) -lt $((b[$k])) ]
then
temp=$((b[$i]))
b[i]=$((b[$k]))
b[k]=$temp
fi
k=$((k+1))
done 
i=$((i+1))
done 


echo -e "\n\nBLOCKSIZE\tFILESIZE\tALLOCATED\tFRAGMENTATION"
i=0
while [ $i -lt $m -a $r -lt $n ]
do 

if [ $((f[$i])) -gt $((b[$i])) ]
then 
echo -e  "\n$((b[$i]))\t\t\t$((f[$i]))\t\t\tNO\t\t\t---"
else

echo -e "\n$((b[$i]))\t\t\t$((f[$i]))\t\t\tYES\t\t\t$((b[$i]-f[$i]))"
           
r=$((r+1))
fi 
i=$((i+1))
done   
;;

2)

declare -a p[20] 
declare -a b[20]
declare -a f[20]
p=0
echo "Enter the number of block:"
read n 
echo "Enter block size:"
for (( i=0; i<n; i++))
do 
read b[$i]
done 
echo "Enter the number of file: "
read m 
echo "Enter file size:"
for (( i=0; i<m; i++))
do 
read f[$i]
done 
for (( i=0; i<n; i++))
do
for (( k=i+1; k<n; k++))
do
if [ $((b[$i])) -gt $((b[$k])) ]
then
temp=$((b[$i]))
b[i]=$((b[$k]))
b[k]=$temp
fi
done 
done 
echo -e "\n\nBlockSize\tFileSize\tALLOCATED\tFRAGMENTATION"
for((i=0; i<m && p<n; i++))
do
if [ $((f[i])) -gt $((b[i])) ]
then
echo -e "\n$((b[i]))\t\t\t$((f[i]))\t\t\tNO\t\t\t---"
else
echo -e "\n$((b[i]))\t\t\t$((f[i]))\t\t\tYES\t\t\t$((b[i] - f[i]))"
p=$((p+1))
fi
done
;;

3)

declare -a p[20] 
declare -a b[20]
declare -a f[20]
p=0
echo "Enter the number of block:"
read n 
echo "Enter block size:"
for (( i=0; i<n; i++))
do 
read b[$i]
done 
echo "Enter the number of file: "
read m 
echo "Enter file size:"
for (( i=0; i<m; i++))
do 
read f[$i]
done 

echo -e "\n\nBlockSize\tFileSize\tALLOCATED\tFRAGMENTATION"
for((i=0; i<m && p<n; i++))
do
if [ $((f[i])) -gt $((b[i])) ]
then
echo -e "\n$((b[i]))\t\t\t$((f[i]))\t\t\tNO\t\t\t---"
else
echo -e "\n$((b[i]))\t\t\t$((f[i]))\t\t\tYES\t\t\t$((b[i] - f[i]))"
p=$((p+1))
fi
done

;;

*)
echo "You enter Invalid number------"
;;

esac

elif [ $operation -eq 0 ]
then 
echo "Program is closed!"
break
fi 
done 
