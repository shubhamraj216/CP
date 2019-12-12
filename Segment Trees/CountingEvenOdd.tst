//
#include<bits/stdc++.h>
using namespace std;
int counteven(int tree[], int start, int end, int left, int right, int nodex){
    if(end<left || start>right){
        return 0;
    }
    if(end<=right && start>=left){
        return tree[nodex];
    }
    int mid=start+(end-start)/2;
    int ans1=counteven(tree, start, mid, left, right, 2*nodex);
    int ans2=counteven(tree, mid+1, end, left, right, 2*nodex+1);
    return ans1+ans2;
}
void update(int tree[], int start, int end, int idx, int val, int nodex){
    if(start==end){
        if(val%2==0){
            tree[nodex]=1;
        }else{
            tree[nodex]=0;
        }
        return;
    }
    int mid=start+(end-start)/2;
    if(idx<=mid){
        update(tree, start, mid, idx, val, 2*nodex);
    }else{
        update(tree, mid+1, end, idx, val, 2*nodex+1);
    }
    tree[nodex]=tree[2*nodex]+tree[2*nodex+1];
}
void buildtree(int arr[], int tree[], int start, int end, int nodex){
    if(start==end){
        if(arr[start]%2==0){
            tree[nodex]=1;
        }else{
            tree[nodex]=0;
        }
        return;
    }
    int mid=start+(end-start)/2;
    buildtree(arr, tree, start, mid, 2*nodex);
    buildtree(arr, tree, mid+1, end, 2*nodex+1);
    tree[nodex]=tree[2*nodex]+tree[2*nodex+1];
}
int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    int n;
    cin>>n;
    int arr[n];
    for(int i=0;i<n;i++){
        cin>>arr[i];
    }
    int* tree=new int[4*n];
    buildtree(arr, tree, 0, n-1, 1);
    // for(int i=0;i<4*n;i++){
    //     cout<<tree[i]<<endl;
    // }
    int q;
    cin>>q;
    while(q--){
        int a,b,c;
        cin>>a>>b>>c;
        if(a==0){
            //update
            update(tree, 0, n-1, b-1, c, 1);
        }else if(a==1){
            //count even
            cout<<counteven(tree, 0, n-1, b-1, c-1, 1)<<endl;
        }else{
            //count odd
            int x=counteven(tree, 0, n-1, b-1, c-1, 1);
            if(c-b+1-x<0){
                cout<<"0"<<endl;
            }else{
                cout<<c-b+1-x<<endl;
            }
        }
    }
}
