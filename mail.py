# Import smtplib for the actual sending function
import smtplib
from email.parser import Parser

# Import the email modules we'll need
from email.mime.text import MIMEText
textfile = '/tmp/mail.txt'
me = '"UPC" <upc.nl@email.upc.nl>'
you = 'menzo_wijmenga@hotmail.com'
# Open a plain text file for reading.  For this example, assume that
# the text file contains only ASCII characters.

message = Parser().parse(open(textfile, 'r'))

# fp = open(textfile, 'rb')
# # Create a text/plain message
# msg = MIMEText(fp.read())
# fp.close()

# # me == the sender's email address
# # you == the recipient's email address
# msg['Subject'] = 'The contents of %s' % textfile
# msg['From'] = me
# msg['To'] = you

# print msg.as_string()
# quit()

# Send the message via our own SMTP server, but don't include the
# envelope header.
s = smtplib.SMTP('localhost', 10025)
s.sendmail(me, [you], message.as_string())
s.quit()
