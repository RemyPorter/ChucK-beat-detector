OscOut oout;
("localhost", 8081) => oout.dest;
oout.start("/test/op").add("data").add(5.0).send();