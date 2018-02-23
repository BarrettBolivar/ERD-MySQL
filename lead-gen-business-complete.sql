/*
1. What query would you run to get the total revenue for March of 2012?
	SELECT DATE_FORMAT(billing.charged_datetime, '%M') AS 'month', SUM(amount) as total_revenue
	FROM billing
	WHERE MONTH(billing.charged_datetime) = 3
	AND YEAR(billing.charged_datetime) = 2012;

2. What query would you run to get total revenue collected from the client with an id of 2?
	SELECT clients.client_id, SUM(billing.amount) FROM clients
	JOIN billing ON billing.client_id = clients.client_id
	WHERE clients.client_id = 2;

3. What query would you run to get all the sites that client=10 owns?
	SELECT sites.domain_name, clients.client_id FROM sites
	JOIN clients ON clients.client_id = sites.client_id
	WHERE sites.client_id = 10;

4. What query would you run to get total # of sites created per month per year for the client with an id of 1? 
What about for client=20?
	SELECT clients.client_id AS ID, COUNT(sites.domain_name) AS number_of_websites, MONTHNAME(sites.created_datetime) as month, 
	YEAR(sites.created_datetime) AS year
	FROM clients
	JOIN sites ON sites.client_id = clients.client_id
	WHERE clients.client_id = 1 #insert 20 for 20#
	GROUP BY sites.created_datetime;

5. What query would you run to get the total # of leads generated for each of the sites between January 1, 2011 
to February 15, 2011?
	SELECT sites.domain_name AS Website, COUNT(leads.leads_id) AS number_of_leads, leads.registered_datetime AS date
	FROM sites
	JOIN leads ON leads.site_id = sites.site_id
	GROUP BY leads.registered_datetime;

6. What query would you run to get a list of client names and the total # of leads we've generated for each of our clients
 between January 1, 2011 to December 31, 2011?
	SELECT CONCAT(clients.first_name, " ", clients.last_name) AS Client, COUNT(leads.leads_id)
	FROM clients
	JOIN sites ON sites.client_id = clients.client_id 
	JOIN leads ON leads.site_id = sites.site_id
	WHERE YEAR(leads.registered_datetime) = 2011
	GROUP BY clients.first_name;

7. What query would you run to get a list of client names and the total # of leads we've generated 
for each client each month between months 1 - 6 of Year 2011?
	SELECT CONCAT(clients.first_name, " ", clients.last_name) AS Client, COUNT(leads.leads_id) AS leads_generated, 
	MONTHNAME(leads.registered_datetime) AS month_generated
	FROM clients
	JOIN sites ON sites.client_id = clients.client_id 
	JOIN leads ON leads.site_id = sites.site_id
	WHERE YEAR(leads.registered_datetime) = 2011
		AND MONTH(leads.registered_datetime) BETWEEN 1 AND 6
	GROUP BY clients.first_name;

8. What query would you run to get a list of client names and the total # of leads we've generated 
for each of our clients' sites between January 1, 2011 to December 31, 2011? Order this query by client id.  
Come up with a second query that shows all the clients, the site name(s), and the total number of leads generated
 from each site for all time.
	SELECT CONCAT(clients.first_name, " ", clients.last_name) AS Client, sites.domain_name AS website, 
	COUNT(leads.leads_id) AS leads_generated, leads.registered_datetime AS date_generated
	FROM clients
	JOIN sites ON sites.client_id = clients.client_id 
	JOIN leads ON leads.site_id = sites.site_id
	WHERE YEAR(leads.registered_datetime) = 2011 #second part - comment this out#
	GROUP BY clients.client_id;

9. Write a single query that retrieves total revenue collected from each client for each month of the year. 
Order it by client id.
	SELECT CONCAT(clients.first_name, " ", clients.last_name) AS Client, SUM(billing.amount) AS total, MONTHNAME(billing.charged_datetime)
	, YEAR(billing.charged_datetime)
	FROM clients
	JOIN billing ON billing.client_id = clients.client_id
	GROUP BY MONTHNAME(billing.charged_datetime), YEAR(billing.charged_datetime)
	ORDER BY clients.client_id;

10. Write a single query that retrieves all the sites that each client owns. Group the results 
so that each row shows a new client. It will become clearer when you add a new field called 'sites' that
 has all the sites that the client owns. (HINT: use GROUP_CONCAT)
	SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS client_name, GROUP_CONCAT(sites.domain_name) AS 'sites'
	FROM clients
	LEFT JOIN sites ON clients.client_id = sites.client_id
	GROUP BY clients.client_id;
*/
