spark -vcg -config_file=spark.cfg @spark
sparksimp -a
pogs -d=factorial -o=factorial.sum
cd factorial

checker -proof_log=factorial.plg