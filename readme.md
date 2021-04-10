## OntopSpark and Sparklify(SANSA) comparison

### Considerations



### Evaluation

|  | Expected output | Sparklify time | OntopSpark time | Notes |
|--|---------------|--------------------|---------------|-------|
| __Q1__ | 2 COL (6 rows) |
| __Q2__ | 10 COL (200 rows) |
| __Q3__ | 4 COL (0 rows) |
| __Q4__ | 4 COL (7 rows) |
| __Q5__ | 3 COL (0 rows) |
| __Q6__ | 1 COL (0 rows) | | no | (1)|
| __Q7__ | 10 COL (30 rows) |
| __Q8__ | 11 COL (6 rows) |
| __Q10__ | 4 COL (6 rows) |
| __ENTAILMENT<br> REGIME (1 run)__ | 3 COL (5100 rows) | not possible | XXX sec | (2) |

__(1)__ the __regex()__ operator is not implemented in OntopSpark

__(2)__ as far as we know, Sparlify is able to execute an entailment regime query only starting from an RDF dataset, but not from a NoSQL file accessed using the OBDA paradigm


### Conclusions

### References

OntopSpark:
  - <https://chimera-suite.github.io/>

Sparklify:
  - <http://sansa-stack.net/sparklify/>
  - <https://github.com/SANSA-Stack/SANSA-Notebooks/wiki/Query-notebook#sparklify-example>
