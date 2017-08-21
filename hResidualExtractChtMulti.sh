cat log.chtMultiRegionSimpleFoam | grep -v 'ExecutionTime' | grep 'Time = '|tr -d 'Time = ' > log.time

cat log.chtMultiRegionSimpleFoam |grep 'Solving for h'|sed '1~5!d'  |cut -d ' ' -f9 |tr -d ',' > log.bottomAir-hResidual
cat log.chtMultiRegionSimpleFoam |grep 'Solving for h'|sed '2~5!d'  |cut -d ' ' -f9 |tr -d ',' > log.topAir-hResidual
cat log.chtMultiRegionSimpleFoam |grep 'Solving for h'|sed '3~5!d'  |cut -d ' ' -f9 |tr -d ',' > log.heater-hResidual
cat log.chtMultiRegionSimpleFoam |grep 'Solving for h'|sed '4~5!d'  |cut -d ' ' -f9 |tr -d ',' > log.leftSolid-hResidual
cat log.chtMultiRegionSimpleFoam |grep 'Solving for h'|sed '5~5!d'  |cut -d ' ' -f9 |tr -d ',' > log.rightSolid-hResidual

paste log.time  log.bottomAir-hResidual log.topAir-hResidual log.heater-hResidual log.leftSolid-hResidual log.rightSolid-hResidual > log.hResidual
sed '1i\# Time bottomAir topAir heater leftSolid rightSolid' -i log.hResidual
sed '1i\# hResidual' -i log.hResidual

#foamMonitor -l log.hResidual

cat log.chtMultiRegionSimpleFoam |grep 'Min/max T'|sed '1~5!d'  |cut -d ' ' -f3 > log.bottomAir-Tmax
cat log.chtMultiRegionSimpleFoam |grep 'Min/max T'|sed '2~5!d'  |cut -d ' ' -f3 > log.topAir-Tmax
cat log.chtMultiRegionSimpleFoam |grep 'Min/max T'|sed '3~5!d'  |cut -d ' ' -f3 > log.heater-Tmax
cat log.chtMultiRegionSimpleFoam |grep 'Min/max T'|sed '4~5!d'  |cut -d ' ' -f3 > log.leftSolid-Tmax
cat log.chtMultiRegionSimpleFoam |grep 'Min/max T'|sed '5~5!d'  |cut -d ' ' -f3 > log.rightSolid-Tmax

paste log.time  log.bottomAir-Tmax log.topAir-Tmax log.heater-Tmax log.leftSolid-Tmax log.rightSolid-Tmax > log.Tmax
sed '1i\# Time bottomAir topAir heater leftSolid rightSolid' -i log.Tmax
sed '1i\# Tmax' -i log.Tmax

#foamMonitor log.Tmax
