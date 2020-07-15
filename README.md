# CS340SMITEProject
A website with a database back end based on the MOBA game SMITE. 
#Specifications

Your database should be pre-populated with sample data. At least three rows per table is expected. The sample data should illustrate a table's functionality, e.g. if the table is part of a many-to-many relationship, the sample data should depict M:M.

Your database should have at least 4 entities and at least 4 relationships, TWO of which must be a many-to-many relationship.  The entities and relationships should implement the operational requirements of your project, see individual project steps for instructions. Note for this project you will be asked to identify 2 M:M relationships in the planning phase, however will only be required one for your final project execution.   

It should be possible to INSERT entries into every table individually.

Every table should be used in at least one SELECT query. For the SELECT queries, it is fine to just display the content of the tables, but your website needs to also have the ability to search using text or filter using a dynamically populated list of properties. This search/filter functionality should be present for at least one entity. It is generally not appropriate to have only a single query that joins all tables and displays them.

You need to include one DELETE and one UPDATE function in your website, for any one of the entities. In addition, it should be possible to add and remove things from at least one many-to-many relationship and it should be possible to add things to all relationships. This means you need INSERT functionality for all relationships as well as entities. And DELETE for at least one many-to-many relationship.

In a one-to-many relationship (like bsg_people to bsg_planets), you should be able to set the foreign key value to NULL (such as on a person in bsg_people), that removes the relationship. In case none of the one-to-many relationships in your database has partial participation, you would need to change that to make sure they can have NULL values.

In a many-to-many relationship, to remove a relationship one would need to delete a row from a table. That would be the case with bsg_people and bsg_certifications. One should be able to add and remove certifications for a person without deleting either bsg_people rows or bsg_certification rows. If you implement DELETE functionality on at least (1) many-to-many relationship table, such that the rows in the relevant entity tables are not impacted, that is sufficient.
