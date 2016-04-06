#include <string>
#include "pitt_msgs/ClustersOutput.h"
#include "pitt_msgs/InliersCluster.h"
#include "../../pitt_object_table_segmentation/src/point_cloud_library/pc_manager.h" // for my static library
#include "../../pitt_object_table_segmentation/src/point_cloud_library/srv_manager.h" // for my static library
#include "tracker_library/tracker_manager.h"

using namespace ros;
using namespace pitt_msgs;
//using namespace geometric_tracking;
using namespace pcm;
using namespace srvm;
using namespace cm;

#define INF 999999.0f  // infinite [m]
#define TRACKER_FORGET_TRESHOLD 3 // time of not consecutive update (remove cluster from tracker)

typedef vector< InliersCluster> InliersClusters;
typedef boost::shared_ptr< ClustersOutput> ClustersOutputPtr;

Publisher trackedClusterPub; // variable to publish the output on the call back
boost::shared_ptr< visualization::PCLVisualizer> vis; // to visualize cloud
bool SHOW_TRACKER = true;			// open viewer with a color for every objects
// state variable to track the previous position
float epsilon = 0.20f; // Radios [m] of the sphere centered in a old object centroid. In which, if an object is in it, than it will have the same ID (recognition traking)
float oldWeigth = 0.6f, newWeigth = 0.4f; // to compute the new position of the object (weighted mean) between the previous and the new data

static long clusterID; // can overflow ???????????????????????????????'

vector< clusterManager> tracker; // the memory of the tracked clusters
vector< clusterManager> shapeAdd, shapeRemove; // the added or removed shape in the tracker in this update
vector< int> updatedCnt; // contains the number of consecutive not updated scan for every clusters tracked in memory
vector< bool> updatedFlag; // for every cluster tracked on memory it contains true if it has been updated at this scan, false otherwise

void createNewTrackedCluster( InliersCluster &cl, vector< clusterManager> &tracker, vector< int> &updatedCnt, vector< bool> &updatedFlag){
	clusterManager tr( cl, clusterID++, epsilon, oldWeigth, newWeigth);
	tracker.push_back( tr);
	shapeAdd.push_back( tr);
	updatedCnt.push_back( 0);
	updatedFlag.push_back( false);
}

void initializeTracker( InliersClusters &clusters, vector< clusterManager> &tracker, vector< int> &updatedCnt, vector< bool> &updatedFlag){
	// initialize tracker the frist time
	for( int i = 0; i < clusters.size(); i++){
		createNewTrackedCluster( clusters[ i], tracker, updatedCnt, updatedFlag);
		ROS_INFO( "create new tracked cluster from initialization %d", i);
	}
}

int getIndexOfMinimumElement(vector<float> d){
	float minD = INF;
	int idx = 0;
	for( int i = 0; i < d.size(); i++)
		if( d[ i] < minD){
			idx = i;
			minD = d[ i];
		}
	return idx;
}

bool containsOnlyInf( vector< float> d){
	for( int i = 0; i < d.size(); i++)
		if( d[ i] != INF)
			return false;
	return true;
}

// TRAKING CALLBACK
void clustersAcquisition(const ClustersOutputConstPtr& clusterObj){
	// get input
	InliersClusters clusters = clusterObj->clusterObjs;
	// reset tracker changes
	shapeAdd.clear();
	shapeRemove.clear();

	// track !!!
	if( tracker.size() == 0){
		initializeTracker( clusters, tracker, updatedCnt, updatedFlag);
	} else { // evolve tracker
		// reset updated flag array
		for( int i = 0; i < updatedFlag.size(); i++)
			updatedFlag[ i] = false;
		// scan for every incoming clusters
		for( int i = 0; i < clusters.size(); i++){
			 // create a variable to contain the distances between an input cluster and all the clusters tracked in memory
			vector< float> distances;
			// scan for every tracked cluster in memory
			string log = "distances: ";
			for( int j = 0; j < tracker.size(); j++){
				float d; // will contain the distance between Tj and Ci
				if( tracker[ j].isWithinRange( clusters[ i], d)){ // spherical range of radius epsilon
					distances.push_back( d);
					log += boost::to_string( d) + " ";
				} else {
					distances.push_back( INF);
					log += "inf ";
				}
			}
			ROS_INFO( "%s", log.c_str());
			// analyze the distance vector to retrieve the right action for tracker memory management
			if( containsOnlyInf( distances)){
				// the cluster is far away from any tracked cluster in memory. So create it
				createNewTrackedCluster( clusters[ i], tracker, updatedCnt, updatedFlag);  // does not update distances vector !!!!!
				ROS_INFO( " created new cluster tracked in memory !!!");
			} else {
				// get the index with the minimum distance
				int j_star = getIndexOfMinimumElement(distances);
				if( updatedFlag[ j_star]){
					ROS_ERROR( " impossible duplicate references between a tracked cluster and two input blobs");
				} else {
					// update tracked position (weighted mean)
					tracker[ j_star].updatePosition( clusters[ i]);
					// reset flag and count
					updatedFlag[ j_star] = true;
					updatedCnt[ j_star] = 0;
					ROS_INFO( " updated claster on memory %d with incoming blob %d", j_star, i);
				}
			}
		}
		// controll the count to eliminate tracked cluster that are not updated for a while
		for( int k = 0; k < updatedFlag.size(); k++)
			if( ! updatedFlag[ k]){
				updatedCnt[ k] += 1;
				if(updatedCnt[ k] >= TRACKER_FORGET_TRESHOLD){
					// set in the eliminate list
					InliersCluster clusterIn = tracker[ k].getMessageInput();
					clusterManager removed( clusterIn, tracker[ k].getClusterId(), epsilon, oldWeigth, newWeigth);
					shapeRemove.push_back( removed);
					// eliminate cluster tracked in memory
					tracker.erase( tracker.begin() + k);
					updatedFlag.erase( updatedFlag.begin() + k);
					updatedCnt.erase( updatedCnt.begin() + k);
					ROS_INFO( " eliminate cluster %d from memory", k);
				}
			}

		// only for loggin bheaviour
		string log1 = " CNT  cluster update: (" + boost::to_string( updatedCnt.size()) + "/" + boost::to_string( tracker.size()) + ") ";
		for( int i = 0; i < updatedCnt.size(); i++)
			log1 += boost::to_string( updatedCnt[ i]) + " ";
		ROS_INFO( "%s", log1.c_str());
		string log2 = " FLAG cluster update: (" + boost::to_string( updatedFlag.size()) + "/" + boost::to_string( tracker.size()) + ") ";
		for( int i = 0; i < updatedFlag.size(); i++)
			log2 += boost::to_string( updatedFlag[ i]) + " ";
		ROS_INFO( "%s", log2.c_str());

	}

	if( SHOW_TRACKER){
		for( int i = 0; i < tracker.size(); i++){
			string clusterName = "cluster_" + tracker[i].getClusterId();
			PCManager::updateVisor( vis, tracker[i].getCloud(), tracker[i].getColorR(), tracker[i].getColorG(), tracker[i].getColorB(), clusterName);
		}
	}

	// prepare node output to be published
	// write actual tracked class
	ClustersOutputPtr trackedClustersObject ( new ClustersOutput);
	if( tracker.size() > 0){ // at least one cluster
		for( int j = 0; j < tracker.size(); j++){ // for all the clusters
			InliersCluster outCl;
			outCl.cloud = PCManager::cloudToRosMsg( tracker[ j].getCloud());
			outCl.inliers = tracker[ j].getInliers();
			outCl.x_centroid = tracker[ j].getStateX();
			outCl.y_centroid = tracker[ j].getStateY();
			outCl.z_centroid = tracker[ j].getStateZ();
			outCl.shape_id = (int)tracker[ j].getClusterId();

			// append this cluster to output
			trackedClustersObject->clusterObjs.push_back( outCl);
		}
	}
	if( shapeAdd.size() > 0){
		// write which shapes are new
		for( int j = 0; j < shapeAdd.size(); j++){
			InliersCluster outCl;
			outCl.cloud = PCManager::cloudToRosMsg( shapeAdd[ j].getCloud());
			outCl.inliers = shapeAdd[ j].getInliers();
			outCl.x_centroid = shapeAdd[ j].getStateX();
			outCl.y_centroid = shapeAdd[ j].getStateY();
			outCl.z_centroid = shapeAdd[ j].getStateZ();
			outCl.shape_id = (int)shapeAdd[ j].getClusterId();

			trackedClustersObject->cluster_added.push_back( outCl);
		}
	}
	if( shapeRemove.size() > 0){
		// write which shapes are new
		for( int j = 0; j < shapeRemove.size(); j++){
			InliersCluster outCl;
			outCl.cloud = PCManager::cloudToRosMsg( shapeRemove[ j].getCloud());
			outCl.inliers = shapeRemove[ j].getInliers();
			outCl.x_centroid = shapeRemove[ j].getStateX();
			outCl.y_centroid = shapeRemove[ j].getStateY();
			outCl.z_centroid = shapeRemove[ j].getStateZ();
			outCl.shape_id = (int)shapeRemove[ j].getClusterId();

			// write which shapes have been deleted
			trackedClustersObject->cluster_removed.push_back( outCl);
		}
	}

	// publish it !!!
	trackedClusterPub.publish( trackedClustersObject);


	ROS_INFO("-----------------------------------------------");
}

// main method of the node
int main(int argc, char **argv){
	init(argc, argv, "geometric_traker");
	NodeHandle n;

	clusterID = 0;

	// set subscriber
	Subscriber sub = n.subscribe ( srvm::TOPIC_OUT_NAME_OBJECT_PERCEPTION, 10, clustersAcquisition); // to the gazebo turtle kinect or real kinect

	// create window to visualize cloud
	if( SHOW_TRACKER)
		vis = PCManager::createVisor( "Geometric Table Tracking");

	// set publisher
	trackedClusterPub = n.advertise< ClustersOutput>( "geometric_traker/trackedCluster", 10); // to another

	spin();

	return 0;
}
