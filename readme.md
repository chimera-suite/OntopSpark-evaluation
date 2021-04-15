## OntopSpark and Squerall(SANSA) comparison

### Considerations

The dataset for testing was taken from the official Sansa-stack repo(https://github.com/SANSA-Stack/SANSA-Stack/tree/develop/sansa-query/sansa-query-spark/src/test/resources/datalake) and it is composed of 5 CSV files and 9 testing queries (Q1 to Q10, Q9 is not present). Additional SPARQL queries have been added to highlight the differences between OntopSpark and Squerall.

Since Squerall runs on a Zeppelin notebook, to make the comparison as similar as possible, we decided to implement a counterpart that on a Jupyter notebook where queries are run using OntopSpark and PySPARQL.

The comparison simulates the user experience in performing a SPARQL query on NoSQL data (CSV files) through the OBDA paradigm, obtaining a result automatically translated into a Spark dataframe. Consequently, the measured execution times of the experiments include the SPARQL querying phase (OBDA querying) and the results translation in a Spark dataframe for both the  Squerall and OntopSpark notebooks.

Since OntopSpark needs an ontology representing the semantic structure of the data, we proceeded to create one by examining the structure of the `.ttl` mapping file used by Squerall. Furthermore, we needed to translate the Squerall's mapping file into the Ontop's `.obda` format for running OntopSpark. In order to perform the same queries for both systems, it was necessary to slightly adapt the mapping translation to the created ontology, as OntopSpark needs to strictly respect the RDF entailment regime of SPARQL in order to perform the inference on the data.

### Evaluation

|  | Expected output | Squerall time | OntopSpark time | Notes |
|--|---------------|------------------|-----------------|-------|
| __Q1__ | 2 COL (6 rows) | 2122 ms | 2147 ms |
| __Q2__ | 12 COL (200 rows) | 673 ms | 1913 ms |
| __Q3__ | 4 COL (0 rows) | 711 ms | 1018 ms |
| __Q4__ | 4 COL (7 rows) | 1533 ms | 1379 ms |
| __Q5__ | 3 COL (0 rows) | 988 ms | 925 ms |
| __Q6__ | 1 COL (0 rows) | 823 ms | not possible | (1)|
| __Q7__ | 10 COL (30 rows) | 1231 ms | 1188 ms |
| __Q8__ | 11 COL (6 rows) | 1613 ms | 1284 ms |
| __Q10__ | 4 COL (6 rows) | 1142 ms | not possible |
| __free_subj_pred__ | 2 COL (563 rows) | not possible | 12746 ms |  |
| __entailment_regime__<br>(single run) | 3 COL (5091 rows) | not possible | 201 sec | (2) |

__(1)__ the __regex()__ operator is not implemented in OntopSpark

__(2)__ as far as we know, SANSA is able to execute an entailment regime query only starting from an RDF dataset, but not from a NoSQL file accessed using the OBDA paradigm


### Conclusions

The comparison showed that the execution times are comparable. The differences between the two solutions are related to the design choices of the two tools and the different programming languages used (OntopSpark+PySPARQL is designed to be run using python, Squerall is designed as a Spark library).

Although OntopSpark was unable to execute the query Q6 due to the missing implementation of the regex() function, in the meantime it has been able to retrieve all the `?s ?p ?o` relations of the dataset using the RDF entailment query, thanks to the integrated reasoner and the full compliance with the RDF syntax and OWL2QL standard. With Squerall, it was not possible to run the RDF entailment query and get the same results.

### References

OntopSpark:
  - <https://chimera-suite.github.io/>

Squerall:
  - <http://sansa-stack.net/squerall-sansa-datalake/>
