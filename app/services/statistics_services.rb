module StatisticsServices

	def user_statistics_per_day
		sql = "select date_trunc('day', created_at) as userdate, count(*) as usercount from users group by date_trunc('day',created_at)"
		create_user_act = ActiveRecord::Base.connection.execute(sql)
		cua_res = create_user_act.values
	
		# Get signin user activity
		sql = "select date_trunc('day', last_sign_in_at) as userdate, count(*) as usercount from users group by date_trunc('day',last_sign_in_at)"
		sign_in_user_act = ActiveRecord::Base.connection.execute(sql)
		siu_res = sign_in_user_act.values
	


		#create full timeline
		cua_activity = (4.weeks.ago.to_date..Date.today).map do |date|
	      		  [date, 
	      		  	(cua_res.select{ |x| x[0].to_date == date }.present? ? cua_res.select{ |x| x[0].to_date == date}.first.last  : 0),
	      		  ] 
	    	end

		siu_activity = (4.weeks.ago.to_date..Date.today).map do |date|
	      		  [date, 
	      			(siu_res.select{ |x| x[0].to_date == date }.present? ? siu_res.select{ |x| x[0].to_date == date}.first.last  : 0)
	      		  ] 
	    	end

	 	user_activity = [ { name: "Users created", data: cua_activity},
	    				  { name: "Users logged in", data: siu_activity}]
	  end

	def account_statistics
		sql = "select date_trunc('day', created_at) as userdate, count(*) as usercount from users group by date_trunc('day',created_at)"
		create_user_act = ActiveRecord::Base.connection.execute(sql)
		cua_res = create_user_act.values
	
		# Get signin user activity
		sql = "select date_trunc('day', last_sign_in_at) as userdate, count(*) as usercount from users group by date_trunc('day',last_sign_in_at)"
		sign_in_user_act = ActiveRecord::Base.connection.execute(sql)
		siu_res = sign_in_user_act.values
	


		#create full timeline
		cua_activity = (4.weeks.ago.to_date..Date.today).map do |date|
	      		  [date, 
	      		  	(cua_res.select{ |x| x[0].to_date == date }.present? ? cua_res.select{ |x| x[0].to_date == date}.first.last  : 0),
	      		  ] 
	    	end

		siu_activity = (4.weeks.ago.to_date..Date.today).map do |date|
	      		  [date, 
	      			(siu_res.select{ |x| x[0].to_date == date }.present? ? siu_res.select{ |x| x[0].to_date == date}.first.last  : 0)
	      		  ] 
	    	end

	    user_activity = [ { name: "Users created", data: cua_activity},
	    				   { name: "Users logged in", data: siu_activity}]

	end

end