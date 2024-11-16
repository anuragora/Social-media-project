# 1. Identify Users by Location
 #Write a query to find all posts made by usersin specific locations such as 'Agra', 'Maharashtra', and 'West Bengal'.
 #Hint: Focus on filtering users by location.
 
SELECT p.post_id, u.user_id, u.username, p.location
FROM post p JOIN users u 
ON p.user_id = u.user_id
WHERE p.location IN ('Agra', 'Maharashtra', 'West Bengal');


#2. Determine the Most Followed Hashtags
#Write a query to list the top 5 most-followed hashtags on the platform.
#Hint: Join relevant tables to calculate the total follows for each hashtag.

SELECT h.hashtag_id, h.hashtag_name, COUNT(hf.user_id) AS total_follows
FROM hashtags h JOIN hashtag_follow hf 
ON h.hashtag_id = hf.hashtag_id
GROUP BY h.hashtag_id, h.hashtag_name
ORDER BY total_follows DESC
LIMIT 5;


#3. Find the Most Used Hashtags
#Identify the top 10 most-used hashtags in posts.
#Hint: Count how many times each hashtag appears in posts

SELECT h.hashtag_id, h.hashtag_name, COUNT(pt.post_id) AS usage_count
FROM hashtags h JOIN post_tags pt 
ON h.hashtag_id = pt.hashtag_id
GROUP BY h.hashtag_id, h.hashtag_name
ORDER BY usage_count DESC
LIMIT 10;


# 4. Identify the Most Inactive User
#Write a query to find users who have never made any posts on the
platform.
#Hint: Use a subquery to identify these users.

SELECT u.user_id, u.username 
FROM users u WHERE u.user_id NOT IN 
     (  SELECT DISTINCT p.user_id
        FROM post p);
        
        
#5. Identify the Posts with the Most Likes
#Write a query to find the posts that have received the highest number of
likes.
#Hint: Count the number of likes for each post.

SELECT p.post_id, p.caption, COUNT(pl.user_id) AS like_count
FROM post p JOIN post_likes pl ON p.post_id = pl.post_id
GROUP BY p.post_id
ORDER BY like_count DESC
LIMIT 1;

#6. Calculate Average Posts per User
#Write a query to determine the average number of posts made by users.
#Hint: Consider dividing the total number of posts by the number of unique users.

SELECT 
    AVG(user_posts.post_count) AS average_posts_per_user
FROM (SELECT user_id,
	COUNT(*) AS post_count
    FROM post GROUP BY user_id
) AS user_posts;


#7. Track the Number of Logins per User
#Write a query to track the total number of logins made by each user.
#Hint: Join user and login tables.

SELECT u.user_id, u.username, COUNT(l.login_id) AS total_logins
FROM users u JOIN login l ON u.user_id = l.user_id
GROUP BY u.user_id, u.username;


#8. Identify a User Who Liked Every Single Post
#Write a query to find any user who has liked every post on the platform.
#Hint: Compare the number of posts with the number of likes by this user.

SELECT pl.user_id, u.username
FROM post p JOIN post_likes pl ON p.post_id = pl.post_id
JOIN users u ON pl.user_id = u.user_id GROUP BY pl.user_id
HAVING COUNT(p.post_id) = (SELECT COUNT(*) FROM post);


#9. Find Users Who Never Commented
#Write a query to find users who have never commented on any post.
#Hint: Use a subquery to exclude users who have commented.

SELECT u.user_id, u.username
FROM users u
WHERE u.user_id NOT IN (SELECT DISTINCT user_id FROM comments);


#10. Identify a User Who Commented on Every Post
#Write a query to find any user who has commented on every post on the platform.
#Hint: Compare the number of posts with the number of comments by this user.

SELECT c.user_id, u.username
FROM post p JOIN comments c ON p.post_id = c.post_id
JOIN users u ON c.user_id = u.user_id
GROUP BY c.user_id
HAVING COUNT(p.post_id) = (SELECT COUNT(*) FROM post);


#11. Identify Users Not Followed by Anyone
#Write a query to find users who are not followed by any other users.
#Hint: Use the follows table to find users who have no followers.

SELECT u.user_id, u.username
FROM users u LEFT JOIN follows f ON u.user_id = f.followee_id
WHERE f.followee_id IS NULL;


#12. Identify Users Who Are Not Following Anyone
#Write a query to find users who are not following anyone.
#Hint: Use the follows table to identify users who are not following others.

SELECT u.user_id, u.username
FROM users u LEFT JOIN follows f ON u.user_id = f.follower_id
WHERE f.follower_id IS NULL;


#13. Find Users Who Have Posted More than 5 Times
#Write a query to find users who have made more than five posts.
#Hint: Group the posts by user and filter the results based on the number of posts.

SELECT user_id, COUNT(*) AS post_count
FROM post GROUP BY user_id
HAVING COUNT(*) > 5;


#14. Identify Users with More than 40 Followers
#Write a query to find users who have more than 40 followers.
#Hint: Group the followers and filter the result for those with a high follower count.

SELECT f.followee_id, COUNT(f.follower_id) AS follower_count
FROM follows f GROUP BY f.followee_id
HAVING COUNT(f.follower_id) > 40;


#15. Search for Specific Words in Comments
#Write a query to find comments containing specific words like "good" or "beautiful."
#Hint: Use regular expressions to search for these words.

SELECT c.comment_id, c.comment_text, u.username
FROM comments c JOIN users u ON c.user_id = u.user_id
WHERE c.comment_text REGEXP 'good|beautiful';


#16. Identify the Longest Captions in Posts
#Write a query to find the posts with the longest captions.
#Hint: Calculate the length of each caption and sort them to find the top 5 longest ones.

SELECT post_id, caption, LENGTH(caption) AS caption_length
FROM post ORDER BY caption_length DESC
LIMIT 5;






