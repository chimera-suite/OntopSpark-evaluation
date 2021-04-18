## OntopSpark and Squerall(SANSA) comparison

### Considerations

The dataset for testing was taken from the official Sansa-stack repo(https://github.com/SANSA-Stack/SANSA-Stack/tree/develop/sansa-query/sansa-query-spark/src/test/resources/datalake) and it is composed of 5 CSV files inspired by the [BSBM benchmark](http://wifo5-03.informatik.uni-mannheim.de/bizer/berlinsparqlbenchmark/). We used the nine original testing queries of SANSA (Q1 to Q10, Q9 not available) plus two additional SPARQL queries to highlight the differences between OntopSpark and Squerall.

Since Squerall runs on a Zeppelin notebook, to make the comparison as similar as possible, we decided to implement a counterpart on a Jupyter notebook where queries are run using OntopSpark and PySPARQL.

The comparison simulates the user experience of an Analyst, which needs to perform several SPARQL queries on NoSQL data (CSV files) through the OBDA paradigm, and obtain the result of each query automatically translated into a Spark dataframe. Consequently, the measured execution times of the experiments include the SPARQL querying phase (OBDA querying) and the translation of the result in a Spark dataframe for both the Squerall and OntopSpark notebooks.

Since OntopSpark needs an ontology representing the semantic structure of the data, we proceeded to create one by examining the structure of the `.ttl` mapping file used by Squerall. Furthermore, we needed to translate the Squerall's mapping file in the Ontop's `.obda` format for running OntopSpark. To perform the same queries for both systems, it was necessary to slightly adapt the mapping translation accordingly to the created ontology, as OntopSpark needs to strictly respect the RDF entailment regime of SPARQL in order to perform the inference on the data.

### Evaluation

The query execution times are taken from a simulation using an AWS machine with XXX vCPU and YYY memory.

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
| __Q10__ | 4 COL (6 rows) | 1142 ms | not possible | (2) |
| __Q(?s ?p)__ | 2 COL (563 rows) | not possible | 12746 ms | (3) |
| __Q(?s ?p ?o)__ | 3 COL (5091 rows) | not possible | 183374 ms | (3) |

__(1)__ the _regex()_ operator is not implemented in OntopSpark

__(2)__ the query violates the  RDF  entailment  regime  of SPARQL (`?product rdfs:label  ?label` and `FILTER (?product > 9)` cannot coexist) because the query asks for triples whose subject is a literal.

__(3)__ as far as we know, SANSA is able to execute _?s ?p_ and _?s ?p ?o_ queries only starting from an RDF dataset using Sparklify, but not from a NoSQL file accessed using the OBDA paradigm


### Conclusions

The comparison showed that the execution times are comparable. The differences between the two solutions are related to the design choices of the two tools and the different programming languages used (OntopSpark+PySPARQL is designed to be run using python, Squerall is designed as a Spark library).

OntopSpark was unable to execute the query Q6 (missing implementation of the _regex()_ function) and Q10 because the query made by  Squerall violates the RDF entailment regime of SPARQL; as it asks for triples whose subject is a literal. However, thanks to the integrated reasoner and the full compliance with the RDF syntax and OWL2QL standard, OntopSpark has been able to execute query Q(?s ?p) which retrieves all the subjects and predicates given a fixed object and query Q(?s ?p ?o) which retrieves the full RDF materialization of the dataset under OWL2QL entailment regime.

### References

OntopSpark:
  - <https://chimera-suite.github.io/>

Squerall:
  - <http://sansa-stack.net/squerall-sansa-datalake/>
  - Testing environment: <https://github.com/SANSA-Stack/SANSA-Notebooks/tree/stack-merge/sansa-notebooks>
