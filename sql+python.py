import psycopg2
import matplotlib.pyplot as plt

username = 'Piustonen'
password = '2010'
database = 'PIUSTONEN01_DB'
host = 'localhost'
port = '5432'

query_1 = '''
select TRIM(vend_name), sum(item_price*quantity) 
from vendors join products using(vend_id) join orderitems using (prod_id)
group by vend_name;
'''

query_2 = '''
select quantity, item_price from orderitems where prod_id = 'BR03' order by quantity;
'''

conn = psycopg2.connect(user=username, password=password, dbname=database, host=host, port=port)

with conn:

    cur = conn.cursor()

    cur.execute(query_1)
    customers = []
    total = []

    for row in cur:
        customers.append(row[0])
        total.append(row[1])

    x_range = range(len(customers))

    figure, (bar_ax, pie_ax, graph_ax) = plt.subplots(1, 3)

    bar_ax.bar(x_range, total, label='Total')
    bar_ax.set_xticks(x_range)
    bar_ax.set_xticklabels(customers)


    pie_ax.pie(total, labels=customers, autopct='%1.1f%%')
  
    cur.execute(query_2)
    quantity = []
    item_price = []
  
    for row in cur:
        quantity.append(row[0])
        item_price.append(row[1])

    graph_ax.plot(quantity, item_price, marker='o',)


    for qnt, price in zip(quantity, item_price):
        graph_ax.annotate(price, xy=(qnt, price), xytext=(-5, -10), textcoords='offset points', rotation = 270)


mng = plt.get_current_fig_manager()
mng.resize(1400, 600)

plt.show()