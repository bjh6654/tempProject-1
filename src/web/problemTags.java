package web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class problemTags {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		JSONParser parser = new JSONParser();
		Database db = new Database();
		try {
			File problem = new File("C:\\Users\\ksaid\\git\\TempProject\\stats\\problemNumber.txt");
            FileReader filereader = new FileReader(problem);
            BufferedReader bufReader = new BufferedReader(filereader);
            
            Iterator<String> iterator;
            String line = "";
            while((line = bufReader.readLine()) != null){
            	Object obj = parser.parse(new FileReader("C:\\Users\\ksaid\\Desktop\\problems\\" + line + ".json"));			 
				JSONObject jsonObject = (JSONObject) obj;
				// loop array
				JSONArray msg = (JSONArray) jsonObject.get("algorithms");
				iterator = msg.iterator();
				while (iterator.hasNext()) {
					String tmp = iterator.next();
					String tmp2 = "";
					for(int i = 0 ; i < tmp.length(); ++i) {
						if(tmp.charAt(i) == '\'') {
							tmp2 += "''";
						}
						else tmp2 += tmp.charAt(i);
					}
					db.insert(tmp2, line);
					//System.out.println(iterator.next() + " : " + line);
				}
            }
            bufReader.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

}
