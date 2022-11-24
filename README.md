# Matrix of Performance
<p align="center">
  <img src="https://i.imgur.com/OXwGGCi.png" alt="application" width="256" />

 <b align="center">Flutter project disgned to simplify performance tracking of students and workers</b>
</p>


<h2>Simple installation</h2>
<p>
1. Go to GitHub [Releases]
2. Download latest Anrodid/Windows release <br>
3. Run <b>.apk .exe</b> file <br>
</p>
<h2>Set up project for development </h2>
<p>
<h3>Cloning Matrix of Performance</h3>
<p>
1. cd to folder that you want use. <br>
2. git clone https://github.com/Wratheus/Matrix-of-Performance.git <br>
</p>

<h3>Obtaining Supabase Client Credentials</h3>
1. Create/Login Supabase account,<br>
2. Go to "setting" -> "API", obtain public key and url for requests,<br>
3. In project folder, create [lib/src/core/database/client_credentials] folder<br>
4. Create [auth.dart] file in that folder, fill the class:<br>

```
  class ClientCredentials{
    static const String key = '';
    static const String url = '';
  }
```

5. In Supabase DB table manager create table "user_tables" <br>
6. Create 4 columns: <br>
  * "id" (type: int-8) <br>
  * "table_name" (type: text) <br>
  * "user_id" (type: uuid) <br>
  * "table" (json) <br>
7. Activate URL Policies for that table <br>
8. Create 4 policies, using supabase templates: <br>
 * Enable insert for authenticated users only <br>
 * Enable delete for users based on user_id <br>
 * Enable select for users based on user_id <br>
 * Enable update for users based on user_id <br>
</p>

<h2>Project examples</h2>

<h3>Windows charts panel look</h3>
<p align="center">
  <img src="https://i.imgur.com/0lxWcUQ.png" alt="application" width="800" />
</p>


<h3>Windows tables panel look</h3>
<p align="center">
  <img src="https://i.imgur.com/McwlVSI.png" alt="application" width="800" />
</p>

<h3>Windows login</h3>
<p align="center">
  <img src="https://i.imgur.com/FnZHHOP.png" alt="application" width="800" />
</p>

<h3>Mobile tables panel look</h3>

<p align="center">
  <img src="https://i.imgur.com/js5Dqf3.jpg" alt="application" width="400" />
</p>

<h3>Mobile charts panel look</h3>

<p align="center">
  <img src="https://i.imgur.com/qg2lSJq.jpg" alt="application" width="400" />
</p>
