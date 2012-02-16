spark -vcg -config_file=spark.cfg @spark
sparksimp -a
pogs -d=gauss -o=gauss.sum
cd gauss

checker -proof_log=gauss.plg