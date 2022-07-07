package com.dma.domain.common.service;

import java.util.LinkedList;
import java.util.Queue;

import org.springframework.stereotype.Service;

@Service
public class SqlService {

    private Queue<String> queue = new LinkedList<>();

    // Inserts the specified element into this queue if it is possible to do so
	// immediately without violating capacity restrictions
    public void add(String value) {
        synchronized (queue) {
            queue.add(value);
        }
    }

    // Removes a single instance of the specified element from this collection
    public void remove(String value) {
        synchronized (queue) {
            queue.remove(value);
        }
    }

    // Retrieves and removes the head of this queue, or returns null if this
    // queue is empty.
    public String poll() {
        String data = queue.poll();
        return data;
    }

    // Returns true if this collection contains no elements
    public boolean isEmpty() {
        return queue.isEmpty();
    }

    // Returns the number of elements in this collection. If this collection
    // contains more than Integer.MAX_VALUE elements, returns Integer.MAX_VALUE
    public int getTotalSize() {
        return queue.size();
    }

}